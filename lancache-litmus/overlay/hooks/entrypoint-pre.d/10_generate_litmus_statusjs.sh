#!/bin/bash
IFS=' '
mkdir -p /data/cachedomains
cd /data/cachedomains || exit 1

sed -i "s/LITMUS_HOSTNAME/${LITMUS_HOSTNAME}/" /etc/nginx/sites-available/litmus.conf.d/10_litmus.conf
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostCACHE_IDENTIFIERChecking=no"
if [[ ! -d .git ]]; then
	git clone "${CACHE_DOMAINS_REPO}" .
fi

if [[ "${NOFETCH:-false}" != "true" ]]; then
	git fetch origin
	git reset --hard "origin/${CACHE_DOMAINS_BRANCH}"
fi

TEMP_PATH=$(mktemp -d)
OUTPUTFILE=${TEMP_PATH}/outfile.js
echo "var cachedomains = {" >>"${OUTPUTFILE}"
jq -c '.cache_domains[]' cache_domains.json | while read -r CACHE_ENTRY; do
	CACHE_IDENTIFIER=$(jq -r '.name' <<<"${CACHE_ENTRY}")
	CACHE_DESCRIPTION=$(jq -r '.description' <<<"${CACHE_ENTRY}")
	CACHEHOSTS_FILEID=$(jq -r '.domain_files[]' <<<"${CACHE_ENTRY}")

	cat <<-EOF >>"${OUTPUTFILE}"
		  "${CACHE_IDENTIFIER}": {
		    "description": "${CACHE_DESCRIPTION}",
		    "domains": [
	EOF

	DOMAINS=()
	for FILE in ${CACHEHOSTS_FILEID}; do
		while IFS= read -r CACHE_HOST; do
			# Remove comments and trim whitespace
			CACHE_HOST="${CACHE_HOST%%#*}"
			CACHE_HOST="$(echo "${CACHE_HOST}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
			if [[ -n "${CACHE_HOST}" ]]; then
				DOMAINS+=("${CACHE_HOST}")
			fi
		done <"${FILE}"
	done

	for ((i = 0; i < ${#DOMAINS[@]}; i++)); do
		DOMAIN="${DOMAINS[i]}"
		if ((i < ${#DOMAINS[@]} - 1)); then
			echo "      \"${DOMAIN}\"," >>"${OUTPUTFILE}"
		else
			echo "      \"${DOMAIN}\"" >>"${OUTPUTFILE}"
		fi
	done
	echo "    ]" >>"${OUTPUTFILE}"
	echo "  }," >>"${OUTPUTFILE}"
done
echo "};" >>"${OUTPUTFILE}"
if [[ -d .git ]]; then
	giturl=$(git config --get remote.origin.url)
	datetime=$(git --no-pager log -1 --format=%cd)
	commit=$(git --no-pager log -1 --format=%h)
	echo "var urltext='Running with hostlist from <a target=\"_blank\" href=\"${giturl}\">${giturl}</a> (version ${commit}, ${datetime})';" >>"${OUTPUTFILE}"
else
	datetime=$(date)
	echo "var urltext='Running with an external hostlist that is not git controlled (Generated at ${datetime})';" >>"${OUTPUTFILE}"
fi
cat "${OUTPUTFILE}"
cp "${OUTPUTFILE}" /var/www/litmus/sites.js
rm -rf "${TEMP_PATH}"
