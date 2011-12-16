#!/usr/bin/env python


import os
import re
import sys


def trailing_whitespace(diff):
    header = False
    line_number = 0

    for line in diff:
        if header:
            # Get the name of the file.
            match = re.match(r'(?:---|\+\+\+) ([^\t]+)', line)
            if match and match.group(1) != '/dev/null':
                filename = match.group(1).split('/', 1)[-1].rstrip()
            if line.startswith('+++ '):
                header = False
            continue
        if line.startswith('diff '):
            header = True
            continue
        # Get the line number.
        match = re.match(r'@@ -\d+,\d+ \+(\d+),', line)
        if match:
            line_number = int(match.group(1))
            continue
        # Check for an added line with trailing whitespace.
        match = re.match(r'\+.*\s$', line.rstrip('\n'))
        if match:
            yield filename, line_number, len(line.rstrip()) + 1
        if line and line[0] in ' +':
            line_number += 1


if __name__ == '__main__':
    diff = os.popen('hg export tip')
    trailing_whitespace_found = False
    for filename, line_number, column_number in trailing_whitespace(diff):
        trailing_whitespace_found = True
        # print >> sys.stderr, ('%s:%d:%d: trailing whitespace' %
        #                       (filename, line_number, column_number))
        print >> sys.stderr, '{0:s}:{1:d}:{2:d}: trailing whitespace'.format(
            filename, line_number, column_number)
    if trailing_whitespace_found:
        # Save the commit message to not have to retype it.
        os.system('hg tip --template "{desc}" > .hg/saved-message.txt')
        print >> sys.stderr, 'commit saved to .hg/saved-message.txt'
        sys.exit(1)
