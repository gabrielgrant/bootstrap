#!/usr/bin/env bash

# Sets up the basics for a well-managed local Python environment:
#  1. adds ~/.local/bin to PATH (see PEP 370)
#  2. tells easy_install to install within ~/.local/
#  3. installs pip and tells it to respect virtualenvs
#  4. installs virtualenv
#  5. installs and configures virtualenvwrapper, using ~/.virtualenvs/
#
# this script assumes that:
#  1. easy_install is globally available
#  2. we can use a file named "~/.bashrc_extras" to extend .bashrc

# create .bashrc if it doesn't exist
touch ~/.bashrc

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

if [ `echo "$PATH" | grep --no-filename -c "$HOME/.local/bin"` ]; then
    echo '
## add PEP 370 bin dir to path
## http://www.python.org/dev/peps/pep-0370/
PATH="/home/gabriel/.local/bin:$PATH"
' >> ~/.bashrc_extras
    
    echo '
## for easy_install
alias easy_install="easy_install --prefix=\"~/.local\""

## for virtualenvwrapper
if [ -f ~/.local/bin/virtualenvwrapper.sh ]; then
    source ~/.local/bin/virtualenvwrapper.sh
fi

## to make pip play nice with virtualenvs
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
' >> ~/.bashrc_extras
fi

echo "slurping in the new changes"
source ~/.bashrc

echo "~/.local/bin is now on PATH: $PATH" 


easy_install --prefix="~/.local"  pip
pip install --user virtualenv
pip install --user virtualenvwrapper
mkdir -p ~/.virtualenvs


