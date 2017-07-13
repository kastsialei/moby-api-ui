#! /bin/sh

set -e

INDEX_FILE=/usr/share/nginx/html/index.html
YAML_FILE=/usr/share/nginx/html/swagger.yaml

replace_in_index () {
  if [ "$1" != "**None**" ]; then
    sed -i "s|/\*||g" $INDEX_FILE
    sed -i "s|\*/||g" $INDEX_FILE
    sed -i "s|$1|$2|g" $INDEX_FILE
  fi
}

replace_or_delete_in_index () {
  if [ -z "$2" ]; then
    sed -i "/$1/d" $INDEX_FILE
  else
    replace_in_index $1 $2
  fi
}

if [[ ! -f $YAML_FILE ]]; then
  wget https://raw.githubusercontent.com/moby/moby/master/api/swagger.yaml -O $YAML_FILE
  sed -i 's|\(basePath: \)".*"|\1 "/docker"|g' $YAML_FILE
  sed -i '/basePath/i host: "'${API_URL:-localhost:8080}'"' $YAML_FILE

fi



exec nginx -g 'daemon off;'
