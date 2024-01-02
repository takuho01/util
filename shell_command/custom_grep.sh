#! /bin/bash

### ussage example
# g hoge
# g hoge *.txt
# g -d 3 hoge
# g hoge -c log
# g -E ".*hoge.*"
# g hoge --outfilename
# find  [ファイル名パターン] -maxdepth [探索階層] -type f | xargs grep [検索文字列]

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--maxdepth)  MAXDEPTH="$2"; shift; shift;;
        -c|--cut)  CUT="$2"; shift; shift;;
        -E|--extended-regexp)  REGEXP="REGEXP"; shift;;
        -i|--input) INPUT="$2"; shift; shift;;
        --) shift;  POSITIONAL_ARGS+=("$@"); set --;;
        -*) echo "[ERROR] Unknown option $1"; exit 1;;
        *)  POSITIONAL_ARGS+=("$1"); shift;;
    esac
done
set -- "${POSITIONAL_ARGS[@]}"  #// set $1, $2, ...
unset POSITIONAL_ARGS

echo "\$MAXDEPTH = \"${MAXDEPTH}\""
echo "\$WILDCARD = \"${WILDCARD}\""
echo "\$FULLPATH = \"${FULLPATH}\""
echo "\$CUT = \"${CUT}\""
echo "\$REGEXP = \"${REGEXP}\""
echo "\$1           = \"$1\""
echo "\$2           = \"$2\""

if [ -n "${REGEXP}" ]; then
    command_regexp="-E "
fi

if [ -n "${MAXDEPTH}" ]; then
    if [ -n "${INPUT}" ]; then
        command_maxdepth_input="find -iname \"*${INPUT}*\" -maxdepth ${MAXDEPTH} -type f | xargs"
    else
        command_maxdepth="find -L * -maxdepth ${MAXDEPTH} -type f | xargs"
    fi
elif [ -n "${INPUT}" ]; then
    command_input="find -iname \"*${INPUT}*\" -type f | xargs"
else
    command_recrusive="-r"
    command_target="*"
fi

if [ -n "${1}" ]; then
    command_input1="\"${1}\""
else
    # quit script
    echo "[ERROR] No input"
    exit 0
fi

if [ -n "${2}" ]; then
    command_target="${2}"
fi

if [ -n "${CUT}" ]; then
    command_cut="| sed \"/${CUT}/d\""
fi

run_command="\
${command_maxdepth_input} ${command_maxdepth} ${command_input} \
grep \
${command_regexp} ${command_recrusive} ${command_input1} ${command_target} \
${command_cut}"

# exec run_command
echo "${run_command}"
echo "------"
eval ${run_command}
echo "------"
echo "${run_command}"


