# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
#
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi


# added by Anaconda 1.9.1 installer
# export PATH="/Users/duffy/anaconda/bin:$PATH"
if [ -d "/usr/local/opt/node@16/bin" ]; then
  export PATH="/usr/local/opt/node@16/bin:$PATH"
fi
if [ -d "/opt/homebrew/opt/node@16/bin" ]; then
  export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
fi
# export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

if [ -e /Users/duffy/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/duffy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="$HOME/.poetry/bin:$PATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# Created by `pipx` on 2023-03-08 19:36:02
export PATH="$PATH:/Users/duffy/.local/bin"
