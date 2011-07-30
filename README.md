# Dot Files

These configuration files set up my command line interface.

## Environment

Be aware that I use Mac OS X; changes will be necessary for Linux users.

To switch to ZSH, execute:

    chsh -s /bin/zsh

I store [scripts](https://github.com/sorin-ionescu/scripts) in _~/.local/bin_. `PATH` and `MANPATH` must be modified in _oh-my-zsh/functions/environment.zsh_, and _MacOSX/environment.plist_ to match your configuration.

Some scripts and programs may have different names or extensions depending on the operating system or package manager. Check aliases in _oh-my-zsh/functions/alias.zsh_ to fix them, if necessary.

## oh-my-zsh Theme

![sorin.oh-my-zsh theme](http://i.imgur.com/aipDQ.png "sorin.oh-my-zsh theme")

The font in the screenshot is Monaco 12 pt—the default fixed-width font on Mac OS X prior to Snow Leopard—which has been replaced by Menlo, based on DejaVu Sans Serif Mono, an inferior font. Change the font to Monaco; otherwise, the indicators described bellow will look terrible.

The colours are from the [IR_BLACK](http://blog.toddwerth.com/entries/show/6) theme.

### Left Prompt

- oh-my-zsh — The current working directory.
- git:master — Git branch.
- ❯ — Type after this.

### Right Prompt

- ❮❮❮ — Vi command mode indicator.
- ⏎  — Non-zero return.
- ✚ — Git added.
- ✹ — Git modified.
- ✖ — Git deleted.
- ➜ — Git renamed.
- ═ — Git non-merged.
- ✭ — Git untracked.

## Authentication

Some programs require that authentication information is stored in their respective dot files. Instead of managing two separate dot file repositories, one for actual use and another sanitised for sharing, I store authentication information in the Mac OS X Keychain. In this case, the dot files will be generated from files of the same name that end in the **.rrc** extension, which stands for **raw rc file**.

The .rrc syntax is `{{ keychain['Entry Name'].account }}` and `{{ keychain['Entry Name'].password }}` respectively. However, this is not [Liquid Markup](http://www.liquidmarkup.org/), and `keychain` is not a real object. It is only meant to feel that way. For example, this is the GitHub API Token snippet from _gitconfig.rrc_.

    [github]
        user = {{ keychain['GitHub API'].account }}
        token = {{ keychain['GitHub API'].password }}

The disadvantage of this method is that the dot files cannot be installed via SSH because Mac OS X disallows Keychain access.

## Installation

Clone this repository into _~/.dotfiles_, change directory into `~/.dotfiles`, and execute `rake`.

    git clone git://github.com/sorin-ionescu/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    rake install

Rake will **never** replace existing files but back them up into *~/.dotfiles_backup*. The dot files will be symlinked into the home directory. Templates will be rendered in place then symlinked. Since the _Rakefile_ is Mac OS X specific, it must be edited for use with key chains on other operating systems. I will welcome patches that add support for additional password managers.

## Vim Text Editor

I use [MacVim](http://code.google.com/p/macvim/) with [Pathogen](https://github.com/tpope/vim-pathogen), which allows for Vim plugins to be installed self-contained under their own directory in _vim/bundle_ making them easy to install and remove.

I recommend the listing of bundles in the bottom of _vimrc_ for use with [vim-update-bundles](https://github.com/sorin-ionescu/vim-update-bundles), which will install and update them.

However, if you wish to manage and update bundles manually (not recommended), you will have to edit _.gitmodules_ then execute the following command.

    git submodule update --init --recursive

The Command-T plugin needs to be compiled:

    cd ~/.vim/bundle/Command-T
    rvm system # If you use Ruby Version Manager (RVM).
    rake make

Alternatively, you can use `rake init` to initialise and compile submodules and `rake update` to update compile submodules.

## Terminals

The _terminal_ directory contains additional configuration files that are not dot files.

- _Sorin.itermcolors_ is a settings file for the Mac OS X [iTerm2.app](http://sites.google.com/site/iterm2home/) to be installed via iTerm2's preferences.
- _Sorin.terminal_ is a settings file for the Mac OS X [Terminal.app](http://en.wikipedia.org/wiki/Apple_Terminal) to be installed by double click.

_iTerm2.app_ supports both 256 colours and mouse. At the time of this writing, it is still of alpha quality; some builds are good while others are buggy. If you favour to continue to use _Terminal.app_, which does not support 256 colours nor mouse under Mac OS X 10.6 Snow Leopard, there are hacks available to improve it. Install [SIMBL](http://www.culater.net/software/SIMBL/SIMBL.php) then install under _~/Library/Application Support/SIMBL/Plugins_ the following plugins.

- [TerminalColours.bundle](https://github.com/brodie/terminalcolours/downloads) to [customise](http://ciaranwal.sh/2007/11/01/customising-colours-in-leopard-terminal) the 8 supported colours.
- [MouseTerm.bundle](http://bitheap.org/mouseterm/) to enable mouse.
- [BounceTerm.bundle](http://bitheap.org/bounceterm/) to bounce the Dock when the terminal beeps.
