#! /bin/bash

command_depth=""
command_cut=""
command_grep=""
command_grep_e=""
command_output_dir=""
command_output_file=""
command_pgrep=""

GREP_ARR=()
GREP_E_ARR=()
CUT_ARR=()

MAXDEPTH=""
FULLPATH=""
OUTPUT_UP=""
PIPE_GREP=""
command_names=""
run_command=""

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        --up) 
			OUTPUT_UP="OUTPUT_UP"; shift;
            ;;
        -d|--maxdepth) 
			MAXDEPTH="$2"; shift; shift;
            ;;
        -g|--grep-dir) 
			GREP_ARR+=("$2"); shift; shift;
            ;;
        -e|--grep_e-dir) 
			GREP_E_ARR+=("$2"); shift; shift;
            ;;
        -c|--cut) 
			CUT_ARR+=("$2"); shift; shift;
            ;;
        --fp|--fullpath) 
			FULLPATH="FULLPATH"; shift; shift;
            ;;
        --cmd) 
			SHOW_CMD="SHOW_CMD"; shift;
            ;;
        --dir) 
			OUTPUT_DIR="OUTPUT_DIR"; shift;
            ;;
        --file) 
			OUTPUT_FILE="OUTPUT_FILE"; shift;
            ;;
        --pg|--pgrep) 
			PIPE_GREP="$2"; shift; shift;
            ;;
        --) 
			shift; POSITIONAL_ARGS+=("$@"); set --;
            ;;
        -*) 
			echo "[ERROR] Unknown option $1"; exit 1;
            ;;
        *) 
			POSITIONAL_ARGS+=("$1"); shift;
            ;;
    esac
done
set -- "${POSITIONAL_ARGS[@]}"  #// set $1, $2, ...
unset POSITIONAL_ARGS

if [ -z "${MAXDEPTH}" ]; then
    if [ "${OUTPUT_UP}" == "OUTPUT_UP" ]; then
        command_depth="-maxdepth 1 "
    else
        command_depth=""
    fi
else
    command_depth="-maxdepth ${MAXDEPTH}"
fi

if [ ${#CUT_ARR[@]} -gt 0 ]; then
    for pattern in "${CUT_ARR[@]}"; do
        command_cut="${command_cut} | grep -iv '$pattern'"
    done
fi

if [ ${#GREP_ARR[@]} -gt 0 ]; then
    for pattern in "${GREP_ARR[@]}"; do
        command_grep="${command_grep} | grep -i '$pattern'"
    done
fi

if [ ${#GREP_E_ARR[@]} -gt 0 ]; then
    for pattern in "${GREP_E_ARR[@]}"; do
        command_grep_e="${command_grep_e} | grep -iE '$pattern'"
    done
fi

command_names=""
if [ "$#" -gt 0 ]; then
    index=1
    for arg in "$@"; do
        if [ $index -eq 1 ]; then
            command_names="-iname \"*$arg*\""
        else
            command_names="${command_names} -a -iname \"*$arg*\""
        fi
        index=$((index+1))
    done
fi

if [ "$OUTPUT_DIR" == "OUTPUT_DIR" ]; then
    command_output_dir="-type d "
fi

if [ "$OUTPUT_FILE" == "OUTPUT_FILE" ]; then
    command_output_file="-type f "
fi

if [ "$PIPE_GREP" == "" ]; then
    command_pgrep=""
else
    command_pgrep=" | xargs grep -iE '$PIPE_GREP'"
fi  

run_command="find -L \
${command_depth} ${command_output_dir} ${command_output_file} \
${command_names} \
${command_cut} ${command_grep} ${command_grep_e} \
${command_pgrep}"

# 実行
eval ${run_command}

if [ -n "${SHOW_CMD}" ]; then
    echo "cmd :: ${run_command}"
fi




