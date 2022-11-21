# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# added by Anaconda 1.9.1 installer
# export PATH="/Users/duffy/anaconda/bin:$PATH"
export PATH="/usr/local/opt/node@16/bin:$PATH"
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
