ENV=dev

if [ "${ENV}" == "dev" ]
then
	#echo "DEV env invoked"
	echo ""
fi

source ${VI_CONF}/bash.addons/default.shrc
source ${VI_CONF}/bash.addons/git.shrc
source ${VI_CONF}/bash.addons/search.shrc
source ${VI_CONF}/bash.addons/ack.shrc

## source this file for alias 
##
