# onsub.py - execute commands recursively on subrepositories
#
# Copyright 2010, 2011 aragost Trifork
#
# This software may be used and distributed according to the terms of
# the GNU General Public License version 2 or any later version.

import os
from mercurial.i18n import _
from mercurial import extensions, subrepo, util

"""execute a command in each subrepository"""

def onsub(ui, repo, *args, **opts):
    """execute a command in each subrepository

    Executes CMD with the current working directory set to the root of
    each subrepository. By default, execution stops if CMD returns a
    non-zero exit code. Use --ignore-errors to override this.

    Use --verbose/-v to print the command being run and the subrepo
    name for each run of CMD in a subrepo. Alternately, use
    --print0/-0 to print just the subrepo name followed by a NUL
    character instead of a newline. This can be useful in combination
    with :hg:`status --print0`.

    The command has access to the following environment variables:

    ``HG_REPO``:
        Absolute path to the top-level repository in which the onsub
        command was executed.

    ``HG_SUBPATH``:
        Relative path to the current subrepository from the top-level
        repository.

    ``HG_SUBURL``:
        URL for the current subrepository as specified in the
        containing repository's ``.hgsub`` file.

    ``HG_SUBSTATE``:
        State of the current subrepository as specified in the
        containing repository's ``.hgsubstate`` file.
    """
    cmd = ' '.join(args)
    foreach(ui, repo, cmd,
            not opts.get('breadth_first'),
            opts.get('max_depth'),
            opts.get('print0'),
            opts.get('ignore_errors'))

def foreach(ui, repo, cmd, depthfirst, maxdepth, print0, ignoreerrors):
    """execute cmd in repo.root and in each subrepository"""
    ctx = repo['.']
    work = [(1, ctx.sub(subpath)) for subpath in sorted(ctx.substate)]
    if depthfirst:
        work.reverse()

    while work:
        if depthfirst:
            (depth, sub) = work.pop()
        else:
            (depth, sub) = work.pop(0)
        if depth > maxdepth >= 0:
            continue

        # subrepo.relpath was renamed to subrepo.subrelpath in
        # 18b5b6392fcf.
        if hasattr(subrepo, 'relpath'):
            relpath = subrepo.relpath(sub)
        else:
            relpath = subrepo.subrelpath(sub)

        if print0:
            ui.write(relpath, "\0")
        else:
            ui.note(_("executing '%s' in %s\n") % (cmd, relpath))
        if ignoreerrors:
            onerr = None
        else:
            onerr = util.Abort
        util.system(cmd, environ=dict(HG_SUBPATH=relpath,
                                      HG_SUBURL=sub._path,
                                      HG_SUBSTATE=sub._state[1],
                                      HG_REPO=repo.root),
                    cwd=os.path.join(repo.root, relpath),
                    onerr=onerr,
                    errprefix=_('terminated onsub in %s') % relpath)

        if isinstance(sub, subrepo.hgsubrepo):
            rev = sub._state[1]
            ctx = sub._repo[rev]
            w = [(depth + 1, ctx.sub(subpath))
                 for subpath in sorted(ctx.substate)]
            if depthfirst:
                w.reverse()
            work.extend(w)

cmdtable = {
    "onsub":
        (onsub,
         [('b', 'breadth-first', None,
           _('use breadth-first traversal')),
          ('', 'max-depth', -1,
           _('limit recursion to N levels (negative for no limit)'), 'N'),
          ('', 'ignore-errors', None,
           _('continue execution despite errors')),
          ('0', 'print0', None,
           _('end subrepository names with NUL, for use with xargs'))],
         _('[-b] [-0] [--ignore-errors] CMD'))
}
