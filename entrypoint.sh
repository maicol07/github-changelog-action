#!/bin/bash
cd /github/workspace/ || exit

while getopts "n:c:o:t:p:" opt; do
  case ${opt} in
    c )
      if [ -z "${OPTARG}" ]; then
        echo "::error ::git-chlog path is not set using flag '-c <configuration directory>'"
        exit 1
      fi
      config=$OPTARG
      ;;
    n )
      if [ ! -z ${OPTARG} ]; then
        next_tag="--next-tag ${OPTARG}"
      fi
      ;;
    o )
      if [ ! -z ${OPTARG} ]; then
        output="${OPTARG}"
      fi
      ;;
    t )
      tag="${OPTARG}"
      ;;
    p )
      path="${OPTARG}"
      ;;
  esac
done
shift $((OPTIND -1))

if [[ ! -z "$path" ]]; then
    echo "::debug ::git-chlog -p options is set. change directory to ${path}"
    cd $path
fi
git config --global --add safe.directory /github/workspace
repository_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}"

if [ -f "${config}/config.yml" ] && [ -f "${config}/CHANGELOG.tpl.md" ]; then
  echo "::debug ::git-chlog: -c '${config}'"
  echo "::debug ::git-chlog: -n '${next_tag}'"
  echo "::debug ::git-chlog: -o '${output}'"
  echo "::debug ::git-chlog: -t '${tag}'"
  echo "::debug ::git-chlog: -p '${path}'"
  echo "::debug ::git-chlog: Repo URL '${repository_url}'"
  echo "::debug ::git-chlog: Repo debug: '${GITHUB_SERVER_URL}' '${GITHUB_REPOSITORY}'"

  git fetch --all --tags

  echo "::info ::git-chlog executing command: /usr/local/bin/git-chglog --config ${config}/config.yml --repository-url=${repository_url} ${tag} --next-tag ${next_tag}"
  changelog=$(/usr/local/bin/git-chglog --config "${config}/config.yml" --repository-url="${repository_url}" "${tag}" --next-tag "${next_tag}")

  echo "::debug ::git-chlog: ----------------------------------------------------------"
  echo "::debug ::git-chlog: ${changelog}"
  echo "::debug ::git-chlog: ----------------------------------------------------------"

  echo "::debug ::git-chlog: -o '${output}'"
  if [[ ! -z "$output" ]]; then
    echo "::debug ::git-chlog -o options is set. writing changelog to ${output}"
    echo "${changelog}" > ${output}
  fi

  echo "changelog=$( echo "$changelog" | jq -sRr @uri )" >> $GITHUB_OUTPUT

else
  echo "::warning ::git-chlog configuration was not found, skipping changelog generation."
fi
