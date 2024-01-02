#! /bin/bash

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        --dir)  DIR="dir"; shift;;
        --file)  FILE="FILE"; shift;;
        -w|--nowild)  WILDCARD="$2"; shift; shift;;
        -d|--maxdepth)  MAXDEPTH="$2"; shift; shift;;
        --fp|--fullpath)  FULLPATH="FULLPATH"; shift; shift;;
        -c|--cut)  CUT="$2"; shift; shift;;
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
echo "\$1           = \"$1\""
echo "\$2           = \"$2\""

command_depth=""
if [ -z "${MAXDEPTH}" ]; then
    command_depth=""
else
    command_depth="-maxdepth ${MAXDEPTH}"
fi

command_wildcard=""
if [ -z "${WILDCARD}" ]; then
    command_wildcard=""
else
    command_wildcard="-iname \"${WILDCARD}\""
fi

command_dir=""
if [ -z "${DIR}" ]; then
    command_dir=""
else
    command_dir="-type d"
fi

command_file=""
if [ -z "${FILE}" ]; then
    command_file=""
else
    command_file="-type f"
fi

command_fullpath=""
if [ -z "${FULLPATH}" ]; then
    command_fullpath=""
else
    command_fullpath="$PWD"
fi

command_cut=""
if [ -z "${CUT}" ]; then
    command_cut=""
else
    command_cut="| sed \"/${CUT}/d\""
fi

command_input1=""
if [ -z "${1}" ]; then
    command_input1=""
else
    command_input1="-iname \"*${1}*\""
fi

run_command="find \
${command_depth} ${command_dir} ${command_file} ${command_wildcard} ${command_fullpath} ${command_input1} \
${command_cut}"

# exec run_command
echo "${run_command}"
echo "------"
eval ${run_command}
echo "------"
echo "${run_command}"


