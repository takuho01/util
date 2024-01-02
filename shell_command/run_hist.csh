#! /bin/csh

set hist_list_file = "/home/takuho/history.txt"

set selected_path = `cat ${hist_list_file} | sed '/tcsh/d' | fzf --tac`

echo $selected_path

