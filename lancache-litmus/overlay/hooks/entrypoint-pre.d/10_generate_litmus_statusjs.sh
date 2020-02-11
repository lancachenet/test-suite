#!/bin/bash
IFS=' '
mkdir -p /data/cachedomains
cd /data/cachedomains

sed -i "s/LITMUS_HOSTNAME/${LITMUS_HOSTNAME}/" /etc/nginx/sites-available/litmus.conf.d/10_litmus.conf
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostCACHE_IDENTIFIERChecking=no"
if [[ ! -d .git ]]; then
	git clone ${CACHE_DOMAINS_REPO} .
fi

if [[ "${NOFETCH:-false}" != "true" ]]; then
	git fetch origin
	git reset --hard origin/${CACHE_DOMAINS_BRANCH}
fi

TEMP_PATH=$(mktemp -d)
OUTPUTFILE=${TEMP_PATH}/outfile.js
echo "var cachedomains = {" >> $OUTPUTFILE
jq -r '.cache_domains | to_entries[] | .key' cache_domains.json | while read CACHE_ENTRY; do 
	# for each cache entry, find the cache indentifier
	CACHE_IDENTIFIER=$(jq -r ".cache_domains[$CACHE_ENTRY].name" cache_domains.json)
	CACHE_DESCRIPTION=$(jq -r ".cache_domains[$CACHE_ENTRY].description" cache_domains.json)
	jq -r ".cache_domains[$CACHE_ENTRY].domain_files | to_entries[] | .key" cache_domains.json | while read CACHEHOSTS_FILEID; do
		# Get the key for each domain files
		echo "	\"${CACHE_IDENTIFIER}\": {" >> $OUTPUTFILE
		echo "		\"description\": \"${CACHE_DESCRIPTION}\"," >> $OUTPUTFILE
		echo "		\"domains\": [" >> $OUTPUTFILE
		jq -r ".cache_domains[$CACHE_ENTRY].domain_files[$CACHEHOSTS_FILEID]" cache_domains.json | while read CACHEHOSTS_FILENAME; do
			# Get the actual file name
			cat ${CACHEHOSTS_FILENAME} | while read CACHE_HOST; do
				# for each file in the hosts file
				# remove all whitespace (mangles comments but ensures valid config files)
				CACHE_HOST=${CACHE_HOST// /}
				if [[ ${CACHE_HOST:0:1} == '#' ]]; then
					continue;
				fi
				if [ ! "x${CACHE_HOST}" == "x" ]; then
					echo "			\"${CACHE_HOST}\"," >> $OUTPUTFILE
				fi
			done
		done
		echo "		]" >> $OUTPUTFILE
		echo "	}," >> $OUTPUTFILE
	done
done
echo "};" >> $OUTPUTFILE
if [[ -d .git ]]; then
	giturl=$(git config --get remote.origin.url)
	datetime=$(git --no-pager log -1 --format=%cd)
	commit=$(git --no-pager log -1 --format=%h)
	echo "var urltext='Running with hostlist from <a target=\"_blank\" href=\"${giturl}\">${giturl}</a> (version ${commit}, ${datetime})';" >> $OUTPUTFILE;
else
	datetime=$(date)
	echo "var urltext='Running with an external hostlist that is not git controlled (Generated at ${date})';" >> $OUTPUTFILE;
fi
cat $OUTPUTFILE
cp $OUTPUTFILE /var/www/litmus/sites.js
rm -rf $TEMP_PATH
