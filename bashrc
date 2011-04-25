# ------------------------------------------------------------------------------
#          FILE:  .bashrc
#   DESCRIPTION:  Bash Shell configuration file.
#        AUTHOR:  Sorin Ionescu (sorin.ionescu@gmail.com)
#       VERSION:  1.1.14
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Interactivity Check
# ------------------------------------------------------------------------------
# Shell is non-interactive. Be done now!
[[ $- != *i* ]] && return


# ------------------------------------------------------------------------------
# Options
# ------------------------------------------------------------------------------
umask 022 # Create files as u=rwx, g=rx, o=rx
ulimit -c unlimited # No resource usage limits.

function traperr { echo "ERROR: ${BASH_SOURCE[1]} at about line ${BASH_LINENO[0]}"; }
#set -o nounset # Expose unset variables.
#set -o errexit # Exit upon first error; avoid cascading errors.
set -o pipefail # Unveil silent exits.
#set -o errtrace
#trap traperr ERR

set -o noclobber # Prevent overwriting files with >.
set -o ignoreeof # Stop CTRL+D from logging me out.
set -o notify # Notify of job termination.

shopt -s checkhash # Check program exists before executing.
shopt -s extglob # Use extended pattern matching.
shopt -s cdspell # Spell check path
shopt -s histappend # Append to the history file.
shopt -s histreedit # Allow re-editing of a failed substitution.
shopt -s histverify # Don't execute retrieved history immediately; allow editing.
shopt -s cmdhist # Remember multiline commands in history.
shopt -s lithist # Don't reformat multi-line cmd into one line with semicolons.
shopt -s checkwinsize #Wrap lines correctly after resizing terminal.


# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
if type -P gwhoami &>/dev/null; then
  function __gnu_utils() {
    local gcmds
    local gcmd
    local cmd
    local prefix

    prefix="$(dirname $(type -P gwhoami | head -n 1) 2>/dev/null)"
    [[ -z "$prefix" ]] && return 1

    # coreutils
    gcmds=('g[' 'gbase64' 'gbasename' 'gcat' 'gchcon' 'gchgrp' 'gchmod'
    'gchown' 'gchroot' 'gcksum' 'gcomm' 'gcp' 'gcsplit' 'gcut' 'gdate'
    'gdd' 'gdf' 'gdir' 'gdircolors' 'gdirname' 'gdu' 'gecho' 'genv' 'gexpand'
    'gexpr' 'gfactor' 'gfalse' 'gfmt' 'gfold' 'ggroups' 'ghead' 'ghostid'
    'gid' 'ginstall' 'gjoin' 'gkill' 'glink' 'gln' 'glogname' 'gls' 'gmd5sum'
    'gmkdir' 'gmkfifo' 'gmknod' 'gmktemp' 'gmv' 'gnice' 'gnl' 'gnohup' 'gnproc'
    'god' 'gpaste' 'gpathchk' 'gpinky' 'gpr' 'gprintenv' 'gprintf' 'gptx' 'gpwd'
    'greadlink' 'grm' 'grmdir' 'gruncon' 'gseq' 'gsha1sum' 'gsha224sum'
    'gsha256sum' 'gsha384sum' 'gsha512sum' 'gshred' 'gshuf' 'gsleep' 'gsort'
    'gsplit' 'gstat' 'gstty' 'gsum' 'gsync' 'gtac' 'gtail' 'gtee' 'gtest'
    'gtimeout' 'gtouch' 'gtr' 'gtrue' 'gtruncate' 'gtsort' 'gtty' 'guname'
    'gunexpand' 'guniq' 'gunlink' 'guptime' 'gusers' 'gvdir' 'gwc' 'gwho'
    'gwhoami' 'gyes')

    # Not part of coreutils, installed separately.
    gcmds=(${gcmds[@]-} 'gsed' 'gtar' 'gtime')

    for gcmd in "${gcmds[@]}"; do
      [[ ! "$(type -P "${prefix}/${gcmd}")" ]] && continue

      #
      # This method allows for builtin commands to be primary but it's
      # lost if hash -r is executed; it has to be wrapped.
      #
      hash -p "${prefix}/${gcmd}" "${gcmd:1}"

      #
      # This method generates wrapper functions. It will override shell
      # builtins and bash_completion will crap out.
      #
      # eval "function ${gcmd:1}() { \"${prefix}/${gcmd}\" \"\$@\"; }"

      #
      # This method is inflexible since the aliases are at risk of being
      # overriden resulting in the BSD coreutils being called.
      #
      # alias "${gcmd:1}"="${prefix}/${gcmd}"
    done

    return 0
  }
  __gnu_utils

  function hash() {
    if [[ "$*" =~ "-r" ]]; then
      builtin hash "$@"
      __gnu_utils
    else
      builtin hash "$@"
    fi;
  }
fi

# The 'ls' family
#-------------------------------------------------------------
[[ "$TERM" != 'dumb' ]] && use_color='true' || use_color='false'
[[ "$use_color" == 'true' ]] && {
  [[ "$(which dircolors)" ]] && use_color_gnu='true' || use_color_bsd='true'
}

[[ "$use_color_gnu" == 'true' ]] && eval $(dircolors $HOME/.dir_colors)
[[ "$use_color_bsd" == 'true' ]] && export CLICOLOR=1
[[ "$use_color_bsd" == 'true' ]] && export LSCOLORS="exfxcxdxbxegedabagacad"

# add colors for filetype recognition
[[ "$use_color_gnu" == 'true' ]] && alias ls='ls -hF --group-directories-first --color=auto'
[[ "$use_color_bsd" == 'true' ]] && alias ls='ls -G -F'

alias la='ls -Ahl'          # show hidden files
alias lx='ls -lhXB'         # sort by extension
alias lk='ls -lhSr'         # sort by size, biggest last
alias lc='ls -lhtcr'        # sort by and show change time, most recent last
alias lu='ls -lhtur'        # sort by and show access time, most recent last
alias lt='ls -lhtr'         # sort by date, most recent last
alias lm='ls -ahl | more'   # pipe through 'more'
alias lr='ls -lhR'          # recursive ls
alias l='ls -lha'
alias ll='ls -lh'

# General
# ------------------------------------------------------------------------------
alias ...='cd ../..'
alias ..='cd ..'
alias cd..='cd ..'
alias cdd='cd - '
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias du='du -kh'
alias df='df -kh'
alias e="$EDITOR"
alias get='curl -C - -O'
alias mkdir='mkdir -p'
alias q='exit'
alias ssh='ssh -X'
alias h='history'
alias j='jobs -l'
alias type='type -a'
alias print-path='echo -e ${PATH//:/\\n}'
alias print-libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias lsbom='lsbom -f -l -s -pf'
alias t="$HOME/.local/bin/t --task-dir ~/.tasks --list todo.txt --delete-if-empty"

if which htop &>/dev/null; then
  alias top=htop
else
  alias topm='top -o vsize'
  alias topc='top -o cpu'
fi

[[ "$use_color" == 'true' ]] && {
  [[ "$(which colordiff)" ]] && alias diff='colordiff'
  [[ "$(which colormake)" ]] && alias make='colormake'
}

# Screen
# ------------------------------------------------------------------------------
[[ "$TERM" == 'xterm-color' ]] && screenrc="$HOME/.screenrc"
[[ "$TERM" == 'xterm-256color' ]] && screenrc="$HOME/.screenrc256"
alias screen="screen -c '$screenrc'"
alias sls="screen -c '$screenrc' -list"
alias surd="screen -c '$screenrc' -aAURD"
alias sus="screen -c '$screenrc' -US"

# TMUX
# ------------------------------------------------------------------------------
[[ "$TERM" == 'xterm-color' ]] && tmuxconf="$HOME/.tmux.conf"
[[ "$TERM" == 'xterm-256color' ]] && tmuxconf="$HOME/.tmux256.conf"
alias tmux="tmux -f '$tmuxconf'"
alias tls="tmux list-sessions"

# Git
# ------------------------------------------------------------------------------
alias g='git'
alias gst='git status'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gd='git diff | mate'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gith="open \`git config -l | grep 'remote.origin.url' | sed -En 's/remote.origin.url=git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'\`"

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'

#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function __git_current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# these aliases take advangate of the previous function
alias ggpull='git pull origin $(__git_current_branch)'
alias ggpush='git push origin $(__git_current_branch)'
alias ggpnp='git pull origin $(__git_current_branch) && git push origin $(__git_current_branch)'


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------
function reload() {
  source "$HOME/.bash_profile"
}

function cdll() {
  if [[ -n "$1" ]]; then
    builtin cd "$1"
    ls -lFhA
  else
    ls -lFhA
  fi
}

function pushdll() {
  if [[ -n "$1" ]]; then
    builtin pushd "$1"
    ls -lFhA
  else
    ls -lFhA
  fi
}

function popdll() {
  builtin popd
  ls -lFhA
}


# OSX Specific Functions
# ------------------------------------------------------------------------------
function tab() {
  local command="cd \\\"$PWD\\\""
  (( $# > 0 )) && command="${command}; $*"
  the_app=$(
    osascript 2>/dev/null <<EOF
      tell application "System Events"
        name of first item of (every process whose frontmost is true)
      end tell
EOF
  )

  [[ "$the_app" == 'Terminal' ]] && {
    osascript 2>/dev/null <<EOF
      tell application "System Events"
        tell process "Terminal" to keystroke "t" using command down
        tell application "Terminal" to do script "${command}" in front window
      end tell
EOF
  }

  [[ "$the_app" == 'iTerm' ]] && {
    osascript 2>/dev/null <<EOF
      tell application "iTerm"
        set current_terminal to current terminal
        tell current_terminal
          launch session "Default Session"
          set current_session to current session
          tell current_session
            write text "${command}"
          end tell
        end tell
      end tell
EOF
  }
}

function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

function pfs() {
  osascript 2>/dev/null <<EOF
    set output to ""
    tell application "Finder" to set the_selection to selection
    set item_count to count the_selection
    repeat with item_index from 1 to count the_selection
      if item_index is less than item_count then set the_delimiter to "\n"
      if item_index is item_count then set the_delimiter to ""
      set output to output & ((item item_index of the_selection as alias)'s POSIX path) & the_delimiter
    end repeat
EOF
}

function cdf() {
  cd "$(pfd)"
}

function pushdf() {
  pushd "$(pfd)"
}

# ------------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------------
function __git_prompt() {
  local git_branch
  local git_dirty_indicator
  [[ $(git rev-parse --git-dir 2>/dev/null) ]] \
    && git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

  [[ -n "$git_branch" ]] && {
    [[ -n "$(git status --porcelain 2>/dev/null)" ]] \
      && git_dirty_indicator='*' \
      || git_dirty_indicator=''
  echo " git:${git_branch}${git_dirty_indicator}"
  }
}

function __bash_prompt_command() {
  # How many characters of the $PWD should be kept
  local pwdmaxlen=25
  # Indicate that there has been dir truncation
  local trunc_symbol=".."
  local dir=${PWD##*/}
  pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
  NEW_PWD=${PWD/#$HOME/\~}
  local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
  if [[ ${pwdoffset} -gt "0" ]]
  then
    NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
    NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
  fi
}

function __bash_prompt() {
  local NONE="\[\033[0m\]"  # unsets color to term's fg color

  # regular colors
  local K="\[\033[0;30m\]"  # black
  local R="\[\033[0;31m\]"  # red
  local G="\[\033[0;32m\]"  # green
  local Y="\[\033[0;33m\]"  # yellow
  local B="\[\033[0;34m\]"  # blue
  local M="\[\033[0;35m\]"  # magenta
  local C="\[\033[0;36m\]"  # cyan
  local W="\[\033[0;37m\]"  # white

  # emphasized (bolded) colors
  local EMK="\[\033[1;30m\]"
  local EMR="\[\033[1;31m\]"
  local EMG="\[\033[1;32m\]"
  local EMY="\[\033[1;33m\]"
  local EMB="\[\033[1;34m\]"
  local EMM="\[\033[1;35m\]"
  local EMC="\[\033[1;36m\]"
  local EMW="\[\033[1;37m\]"

  # background colors
  local BGK="\[\033[40m\]"
  local BGR="\[\033[41m\]"
  local BGG="\[\033[42m\]"
  local BGY="\[\033[43m\]"
  local BGB="\[\033[44m\]"
  local BGM="\[\033[45m\]"
  local BGC="\[\033[46m\]"
  local BGW="\[\033[47m\]"

  local UC="$EMM"              # user's color
  (( $UID == 0 )) && UC="$EMR" # root's color

  if [[ "$use_color" == 'true' ]]; then
    PS1="${C}\${NEW_PWD}${NONE}\$(__git_prompt) ${UC}❯ ${NONE}"
  else
    PS1="\${NEW_PWD}\$(__git_prompt) ❯ "
  fi
}

export PROMPT_COMMAND=__bash_prompt_command
__bash_prompt
unset __bash_prompt
