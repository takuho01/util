#! /bin/sh

if ($#argv == 0) then
	set dbuf = `tac ~/.powered_cd.log | fzf`
	if ($dbuf == '') then
	else
		chdir "${dbuf}"
	endif
else if ($#argv == 1) then
	chdir $1
endif

## add log ###
pwd >> ~/.powered_cd.log

#cut buttom hist if its same to current hist
sh ~/util/shell/cut_cdhist.sh
