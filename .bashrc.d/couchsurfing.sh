# setup couchsurfing stuff
prevdir=$PWD
cd $HOME/csbox
source $HOME/csbox/sh_csbox.sh
cd $prevdir
export RAILS_ENV=development

# not sure why this needs to be done repeadetly
ssh-add $HOME/.ssh/id_rsa


