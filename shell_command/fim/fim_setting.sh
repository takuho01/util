
# include this file
# . this_file

# FIM_PATH="path/to/fim"
FIM_PATH="~/util/shell_command/fim"
# alias fim="$FIM_PATH/fim.sh"
alias fim="$FIM_PATH/fim.py"
alias ff="source $FIM_PATH/ff.sh"
alias ff02="source $FIM_PATH/ff02.sh"
alias ffl="source $FIM_PATH/ff.sh -l"
alias ffc="source $FIM_PATH/ff.sh -c"
alias ffless="less $fim_var"
alias ffcd="cd $fim_var"
alias ffvim="vim $fim_var"

# set json path
export FIM_JSON_PATH="$FIM_PATH/fim_json"
