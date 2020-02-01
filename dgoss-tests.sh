#!/bin/bash


### Parse options

# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null 
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo 'I’m sorry, `getopt --test` failed in this environment.'
    exit 1
fi

#Use t: or thing: to get a fileoption

OPTIONS=dvckl:i:
LONGOPTS=docker,verbose,circleci,keepimage,edit,log:,imagename::

# Defaults
VERBOSE=false
DEBUG=false
CIRCLECI=false
KEEPIMAGE=false
IMAGENAME="lancachenet:goss-test"
SAVELOG=false
LOGFILE="docker.log"
DGOSSEDIT=false
ENGINE="dgoss"

# -regarding ! and PIPESTATUS see above
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    # e.g. return value is 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -d|--docker)
            ENGINE="docker"
			shift
			;;
        -v|--verbose)
            if [[ "$VERBOSE" == "true" ]]; then
				DEBUG=true
			else
				VERBOSE=true
			fi
            shift
            ;;
        -c|--circleci)
            CIRCLECI=true
			SAVELOG=true
			LOGFILE="reports/goss/container.log"
            shift
            ;;
        -k|--keepimage)
            KEEPIMAGE=true
            shift
            ;;
        --edit)
            DGOSSEDIT=true
            shift
            ;;
        -l|--log)
            SAVELOG=true
			LOGFILE="$2"
            shift 2
            ;;
        -i|--imagename)
			IMAGENAME="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

# handle any non-option arguments

#if [[ $# -lt 1 ]]; then
#    echo "$0: At least an imagename is required"
#    exit 4
#fi

if [[ "$DEBUG" == "true" ]]; then
	echo "VERBOSE= $VERBOSE"
	echo "DEBUG= $DEBUG"
	echo "CIRCLECI= $CIRCLECI"
	echo "KEEPIMAGE= $KEEPIMAGE"
	echo "IMAGENAME=\"$IMAGENAME\""
	echo "SAVELOG=$SAVELOG"
	echo "LOGFILE=\"$LOGFILE\""
	echo "ENGINE=$ENGINE"
	echo "DGOSSEDIT=$DGOSSEDIT"
fi

### Start Script


which goss
if [ $? -ne 0 ]; then
	echo "Please install goss from https://goss.rocks/install"
	echo "For a quick auto install run the following"
	echo "curl -fsSL https://goss.rocks/install | sh"
	exit $?
fi

GOSS_WAIT_OPS="-r 60s -s 1s"

docker build --tag "$IMAGENAME" .

if [[ "$CIRCLECI" == "true" ]]; then
	mkdir -p ./reports/goss
	export GOSS_OPTS="$GOSS_OPTS --format junit"
fi

export CONTAINER_LOG_OUTPUT="$LOGFILE"


if [[ "$CIRCLECI" == "true" ]]; then
	dgoss run $@ $IMAGENAME > reports/goss/report.xml
else
	if [[ "$DGOSSEDIT" == "true" ]]; then
		DCOMMAND=edit
	else
		if [[ "$ENGINE" == "docker" ]]; then
			DCOMMAND="run --rm"
		else
			DCOMMAND=run
		fi
	fi
	$ENGINE $DCOMMAND $@ $IMAGENAME
fi

#store result for exit code
RESULT=$?


if [[ "$CIRCLECI" == "true" ]]; then
	echo \
"Container Output:
$(cat reports/goss/container.log)" \
	> reports/goss/container.log
	#delete the junk that goss currently outputs :(
	sed -i '0,/^</d' reports/goss/report.xml
	#remove invalid system-err outputs from junit output so circleci can read it
	sed -i '/<system-err>.*<\/system-err>/d' reports/goss/report.xml
fi

[[ "$VERBOSE" == "true" ]] && cat "$LOGFILE"

[[ "$SAVELOG" == "false" ]] && [[ "$ENGINE" == "dgoss" ]] && rm "$LOGFILE"

[[ "$KEEPIMAGE" == "false" ]] && echo "Deleting docker image" && docker rmi $IMAGENAME

exit $RESULT
