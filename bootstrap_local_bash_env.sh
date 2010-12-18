#!/usr/bin/env bash

# Sets up the basics for a well-managed local bash environment:
#  1. adds ~/.local/bin to PATH (formalized in PEP 370, but used elsewhere)
#
# this script assumes that:
#  1. we can use a file named "~/.bashrc_extras" to extend .bashrc
#  2. we can use a file named "~/.profile_extras" to extend .profile
#
# We need to deal with both profile and bashrc, because some of this
# we want to happen on every bash execution -- interactive or not -- 
# while some we only need on interactive logins.
# This issue becomes particularly important when dealing with Fabric,
# which uses non-interactive logins by default (and thus ignores .bashrc)
#
# From bash manpage:
#
#  > it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile,
#  > in  that order, and reads and executes commands from the first one that
#  > exists and is readable.
#
# So we need to identify if any of these exist. If not, we'll create a .profile.

# create .bashrc if it doesn't exist
touch ~/.bashrc

echo `ls -a`
echo "Finding PROFILE..."
echo `ls -a *profile*` `ls -a *bash*`

# look for ~/.bash_profile, ~/.bash_login, and ~/.profile
if [ -f ~/.bash_profile ]; then
	echo 'PROFILE="$HOME/.bash_profile"'
    PROFILE="$HOME/.bash_profile"
#    echo $PROFILE
#else if [ -f ~/.bash_login ]; then
#    PROFILE="$HOME/.bash_login"
#else if [ -f ~/.profile ]; then
#    PROFILE="$HOME/.profile"
else
    echo "Creating .profile since it doesn't exist"
    touch ~/.profile
    PROFILE="$HOME/.profile"
fi

echo "Using profile: $PROFILE"
echo `ls -a ~/`

# include a new file within bashrc, so we don't have to screw around
# with the original
if [ "$(grep 'bashrc_extras' ~/.bashrc)" ]; then
    echo "~/.bashrc already contains bashrc_extras. Moving right along..."
else
    echo '
if [ -f ~/.bashrc_extras ]; then
    . ~/.bashrc_extras
fi
' >> ~/.bashrc
fi

# same for ~/.profile
if [ "$(grep 'profile_extras' $PROFILE)" ]; then
    echo "$PROFILE already contains profile_extras. Moving right along..."
else
    echo '
if [ -f ~/.profile_extras ]; then
    . ~/.profile_extras
fi
' >> $PROFILE
fi

if [ `echo "$PATH" | grep --no-filename -c "~/.local/bin"` == 0 ]; then
    echo '
## add PEP 370 bin dir to path
## http://www.python.org/dev/peps/pep-0370/
export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH=~/.local/lib/
' >> ~/.profile_extras
    
fi
