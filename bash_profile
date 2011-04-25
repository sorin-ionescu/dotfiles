# ------------------------------------------------------------------------------
#          FILE:  .bash_profile
#   DESCRIPTION:  Bash Shell configuration file.
#        AUTHOR:  Sorin Ionescu <sorin.ionescu@gmail.com>
#       VERSION:  1.0.6
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# System Check
# ------------------------------------------------------------------------------
[[ -f "/etc/bashrc" ]] && source /etc/bashrc


# ------------------------------------------------------------------------------
#  Exports
# ------------------------------------------------------------------------------
export FIGNORE=DS_Store
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HOSTFILE="$HOME/.hosts"
export DISPLAY=":0.0"
export INPUTRC="$HOME/.inputrc"
export EDITRC="$HOME/.editrc"
export BROWSER="safari"
export NODE_PATH="/usr/local/lib/node"

# PATH
# ------------------------------------------------------------------------------
export PATH=$HOME/.local/bin:$HOME/.local/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin$(cat /etc/paths.d/* | sed 's/^/:/g' | tr -d '\n')
export MANPATH=$HOME/.local/share/man:/usr/local/share/man:/usr/share/man$(cat /etc/paths.d/* | sed 's/^/:/g' | tr -d '\n')

# Language
# ------------------------------------------------------------------------------
export LC_ALL=""
export LANG="en_AU.UTF-8"
export LC_COLLATE="en_AU.UTF-8"
export LC_CTYPE="en_AU.UTF-8"
export LC_MESSAGES="en_AU.UTF-8"
export LC_MONETARY="en_AU.UTF-8"
export LC_NUMERIC="en_AU.UTF-8"
export LC_TIME="en_AU.UTF-8"

# Editors
# ------------------------------------------------------------------------------
export EDITOR="vim"
export VISUAL="vim"
export PAGER='less'

# History
# ------------------------------------------------------------------------------
export HISTCONTROL="erasedupes"
export HISTFILESIZE=409600
export HISTIGNORE='history:&:ls:ll:la:[bf]g:h:exit:clear'
export HISTSIZE=100000

# Grep Colours
# ------------------------------------------------------------------------------
[[ "$TERM" != 'dumb' ]] && {
  export GREP_OPTIONS="--color=auto"
  export GREP_COLOR="37;45"
}

# ------------------------------------------------------------------------------
# Less
# ------------------------------------------------------------------------------
export LESSCHARSET="UTF-8"
export LESSHISTFILE='-'
export LESSEDIT='vim ?lm+%lm. %f'
export LESS='-c -F -i -M -R -S -w -X -z-4'
[[ "$(which lesspipe.sh)" ]] && \
  export LESSOPEN='|/usr/bin/env lesspipe.sh %s 2>&-'

# Termcap Colours
# ------------------------------------------------------------------------------
[[ "$TERM" != 'dumb' ]] && {
  export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinking
  export LESS_TERMCAP_md=$'\E[01;31m'      # begin bold
  export LESS_TERMCAP_me=$'\E[0m'          # end mode
  export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
  export LESS_TERMCAP_so=$'\E[00;47;30m'   # begin standout-mode
  export LESS_TERMCAP_ue=$'\E[0m'          # end underline
  export LESS_TERMCAP_us=$'\E[01;32m'      # begin underline
}


# ------------------------------------------------------------------------------
# Includes
# ------------------------------------------------------------------------------

# Bash Completion Library
# ------------------------------------------------------------------------------
brew_prefix="$(brew --prefix 2>/dev/null)"
if [[ -f "$brew_prefix/etc/bash_completion" ]]; then
  source "$brew_prefix/etc/bash_completion"
  source "$brew_prefix/Library/Contributions/brew_bash_completion.sh"
elif [[ -f "$HOME/.local/etc/bash_completion" ]]; then
  source "$HOME/.local/etc/bash_completion"
fi

# Compleat
# ------------------------------------------------------------------------------
if which compleat &>/dev/null && \
  [[ -f "$HOME/.local/share/compleat-1.0/compleat_setup" ]]; then
  source "$HOME/.local/share/compleat-1.0/compleat_setup"
fi

# RVM
# ------------------------------------------------------------------------------
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Python Virtual Environments
# ------------------------------------------------------------------------------
export WORKON_HOME="$HOME/.local/pyenv"
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] \
  && "source /usr/local/bin/virtualenvwrapper.sh"

# Fortune
# ------------------------------------------------------------------------------
if which fortune &>/dev/null; then
  echo
  fortune -s
  echo
fi

# bashrc
# ------------------------------------------------------------------------------
[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

