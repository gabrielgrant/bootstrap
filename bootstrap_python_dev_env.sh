#!/usr/bin/env bash

# Sets up the basics of an efficient Python dev environment:
#
# 1. Installs and sets up IPython
# 2. Installs Fabric
#
# Assumes that bootstrap_local_python_env.sh has already run.
#

pip install --user ipython

echo "
## to make ipython play nice with virtualenv, add this to ~/.bashrc_extras
alias ipython=\"python -c 'import IPython; IPython.Shell.IPShell().mainloop()'\"
" >>  ~/.bashrc_extras

# install the latest Fabric
pip install --user git+git://fabfile.org/fabric.git
