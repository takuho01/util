#!/bin/bash

OUTPUT_LINE=""
CLEAR_INPUT=""

if [ -z "$POSITIONAL_ARGS" ]; then
    POSITIONAL_ARGS=()
fi

# POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -l|--line)
            OUTPUT_LINE="OUTPUT_LINE"
            shift
            ;;
        -c|--clear)
            CLEAR_INPUT="CLEAR_INPUT"
            shift
            ;;
        # to send argv for ff, this option is cut off.
        # -*)
        #     echo "[ERROR] Unknown option $1"
        #     exit 1
        #     ;;
        *)
            POSITIONAL_ARGS+=("$1")
            shift
            ;;
    esac
done
# set -- "${POSITIONAL_ARGS[@]}"

tmpfile="$HOME/tmp/ff_output"
# echo "${POSITIONAL_ARGS[@]}" 
fim --up "${POSITIONAL_ARGS[@]}" > "$tmpfile"
count=$(wc -l < "$tmpfile")


if [[ "$CLEAR_INPUT" == "CLEAR_INPUT" ]]; then
    echo "CLEAR_INPUT"
    POSITIONAL_ARGS=()
elif [[ $count -eq 1 ]]; then
    fim_var=$(head -1 "$tmpfile")
    echo ""
    echo "[RESULT]"
    cat "$tmpfile"
    echo ""
    echo "[input]"
    echo "${POSITIONAL_ARGS[@]}"
    echo ""
    echo "[fullpath]"
    realpath "$fim_var"
    echo ""
    echo "[fim_var] -> $fim_var"
    echo ""
elif [[ $count -gt 1 ]]; then
    if [[ "$OUTPUT_LINE" == "OUTPUT_LINE" ]]; then
        echo ""
        echo "[RESULT]"
        cat "$tmpfile"
        echo ""
        echo ""
        echo "[input]"
        echo "${POSITIONAL_ARGS[@]}"
    else
        echo ""
        echo "[RESULT]"
        cat "$tmpfile" | perl -0777 -pe 's/\n/  /g'
        echo ""
        echo ""
        echo "[input]"
        echo "${POSITIONAL_ARGS[@]}"
    fi
else
    echo "input :  ${POSITIONAL_ARGS[@]}"
    echo "[ERROR] No item found."
fi





