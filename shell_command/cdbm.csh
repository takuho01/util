#!/bin/csh

set path_list_file = "/home/takuho/util/shell_command/path_list.txt"

# path_list.txtからパスを読み込み、fzfで選択
set selected_path = `cat ${path_list_file} | fzf --reverse | sed -e "s/^.*://"`

# 選択されたパスが空でない場合、そのディレクトリに移動
if ( "$selected_path" != "" ) then
    cd "$selected_path"
endif




