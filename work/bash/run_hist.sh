#! /bin/sh

set cmd = `history | tac | sed -e 's/^...[0-9]\+\s\+[0-9]\+.[0-9]\+\s\+//g' | sed '/^cd /d' |  fzf`
echo $cmd
