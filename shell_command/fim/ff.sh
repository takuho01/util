#!/bin/bash

OUTPUT_LINE=""
RESET_INPUT=""

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
        -r|--reset)
            RESET_INPUT="RESET_INPUT"
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
echo "${POSITIONAL_ARGS[@]}" 
fim --up "${POSITIONAL_ARGS[@]}" > "$tmpfile"
count=$(wc -l < "$tmpfile")


if [[ "$RESET_INPUT" == "RESET_INPUT" ]]; then
    echo "RESET_INPUT"
    POSITIONAL_ARGS=()
elif [[ $count -eq 1 ]]; then
    fim_var=$(head -1 "$tmpfile")
    cat "$tmpfile"
    echo ""
    echo "input :  ${POSITIONAL_ARGS[@]}"
    echo "[fim_var] --> $fim_var"
    realpath "$fim_var"
    echo ""
elif [[ $count -gt 1 ]]; then
    if [[ "$OUTPUT_LINE" == "OUTPUT_LINE" ]]; then
        cat "$tmpfile"
        echo ""
        echo ""
        echo "input :  ${POSITIONAL_ARGS[@]}"
    else
        cat "$tmpfile" | perl -0777 -pe 's/\n/  /g'
        echo ""
        echo ""
        echo "input :  ${POSITIONAL_ARGS[@]}"
    fi
else
    echo "input :  ${POSITIONAL_ARGS[@]}"
    echo "[ERROR] No item found."
fi





