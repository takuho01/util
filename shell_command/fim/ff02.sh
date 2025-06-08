#! /usr/bin/bash

json_file="$FIM_PATH/hoge.json"

CLEAR_FLAG=$(/home/takuho/util/shell_command/fim/ffbuf.py --ijson_update ./hoge.json "$@" )

if [ "$CLEAR_FLAG" = "CLEAR" ]; then
    echo "CLEAR"
else
    fim --ijson hoge.json
fi
# fim --ijson hoge.json
