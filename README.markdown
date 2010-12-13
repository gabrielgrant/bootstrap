# Bootstrap Scripts

Copyright Gabriel Grant, 2010

##bootstrap_local_python_env.sh

Sets up the basics for a well-managed local Python environment:

  1. adds ~/.local/bin to PATH (see PEP 370)
  2. tells easy_install to install within ~/.local/
  3. installs pip and tells it to respect virtualenvs
  4. installs virtualenv
  5. installs and configures virtualenvwrapper, using ~/.virtualenvs/

this script assumes that:

  1. easy_install is globally available
  2. we can use a file named "~/.bashrc_extras" to extend .bashrc

##bootstrap_python_dev_env.sh

Sets up the basics of an efficient Python dev environment:

 1. Installs and sets up IPython
 2. Installs Fabric

Assumes that bootstrap_local_python_env.sh has already run.
