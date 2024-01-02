#! /bin/bash





# ###########################
# POSITIONAL_ARGS=()
# while [[ $# -gt 0 ]]; do
#     case $1 in
#         -w|--wildcard_manualy)  WILDCARD="$2"; shift; shift;;
#         -w=*|--wildcard_manualy=*) ARG="$1";  WILDCARD="${ARG#*=}"; unset ARG; shift;;
#         -d|--maxdepth)  MAXDEPTH="$2"; shift; shift;;
#         -d=*|--maxdepth=*) ARG="$1";  MAXDEPTH="${ARG#*=}"; unset ARG; shift;;
#         --) shift;  POSITIONAL_ARGS+=("$@"); set --;;
#         -*) echo "[ERROR] Unknown option $1"; exit 1;;
#         *)  POSITIONAL_ARGS+=("$1"); shift;;
#     esac
# done
# set -- "${POSITIONAL_ARGS[@]}"  #// set $1, $2, ...
# unset POSITIONAL_ARGS

# echo "\$SEARCH_PATH = \"${SEARCH_PATH}\""
# echo "\$MAXDEPTH = \"${MAXDEPTH}\""
# echo "\$WILDCARD = \"${WILDCARD}\""
# echo "\$1           = \"$1\""
# echo "\$2           = \"$2\""

# command_depth=""
# if [ -z "${MAXDEPTH}" ]; then
#     command_depth=""
# else
#     command_depth="-maxdepth ${MAXDEPTH}"
# fi

# command_wildcard=""
# if [ -z "${WILDCARD}" ]; then
#     command_wildcard=""
# else
#     command_wildcard="-iname \"${WILDCARD}\""
# fi

# command_input1=""
# if [ -z "${1}" ]; then
#     command_input1=""
# else
#     command_input1="-iname \"*${1}*\""
# fi

# run_command="find ${command_depth} ${command_wildcard} ${command_input1}"

# # exec run_command
# echo "${run_command}"
# echo "------"
# eval ${run_command}
