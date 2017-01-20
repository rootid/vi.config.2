ENV=dev

if [ "${ENV}" == "dev" ]
then
  source ${VI_CONF}/bash.addons/default.shrc
fi
source ${VI_CONF}/bash.addons/git.shrc
source ${VI_CONF}/bash.addons/search.shrc
source ${VI_CONF}/bash.addons/ack.shrc

## source this file 
