#! /bin/tcsh -x

set OUTPUT_LINE = ""
set RESET_INPUT = ""

if ( ! $?POSITIONAL_ARGS ) then
    set POSITIONAL_ARGS = ()
endif

while ($#argv > 0)
    switch ($argv[1])
        case "-l": case "--line": 
            set OUTPUT_LINE = "OUTPUT_LINE"; shift argv; breaksw
        case "-r": case "--reset": 
            set RESET_INPUT = "RESET_INPUT"; shift argv; breaksw
        # to send argv for ff, this option is cut off.
        # case -*: 
        #     echo "[ERROR] Unknown option $argv[1]"; exit 1; breaksw
        default: 
            set POSITIONAL_ARGS = ($POSITIONAL_ARGS $argv[1]); shift argv; breaksw
    endsw
end

set tmpfile = "$HOME/tmp/ff_output"
echo "$POSITIONAL_ARGS"
fim --up $POSITIONAL_ARGS > $tmpfile
set count = `wc -l < $tmpfile`

if ( "$RESET_INPUT" == "RESET_INPUT" ) then
    echo "RESET_INPUT"
    set POSITIONAL_ARGS = ()
else if ( $count == 1 ) then
    set fim_var = "`head -1 $tmpfile`"
    cat $tmpfile
    echo ""
    echo "input :  $POSITIONAL_ARGS"
    echo "[fim_var] --> $fim_var"
    realpath "$fim_var"
    echo ""
else if ( $count > 1 ) then
    if ( "$OUTPUT_LINE" == "OUTPUT_LINE" ) then
        cat $tmpfile
        echo ""
        echo ""
        echo "input :  $POSITIONAL_ARGS"
    else
        cat $tmpfile | perl -0777 -pe 's/\n/  /g'
        echo ""
        echo ""
        echo "input :  $POSITIONAL_ARGS"
    endif
else
    echo "$count"
    echo "input :  $POSITIONAL_ARGS"
    echo "[ERROR] No item found."
endif


