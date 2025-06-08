# include this file
# . 

# FIM_PATH="path/to/fim"
setenv FIM_PATH "~/util/shell_command/fim"
alias fim "$FIM_PATH/fim.sh"
alias ff "source $FIM_PATH/ff.csh"
alias ffc "source $FIM_PATH/ff.csh -c"
alias ffl "source $FIM_PATH/ff.csh -l"

alias ffless "less $fim_var"
alias ffcd "cd $fim_var"
alias ffvim "vim $fim_var"

