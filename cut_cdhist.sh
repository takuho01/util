#! /bin/bash

hist1=$(tail -n1  ~/.powered_cd.log | sed -e 's/\s//g')
hist2=$(tail -n2  ~/.powered_cd.log | sed -e '$d' | sed -e 's/\s//g')


if [ ${hist1} =  ${hist2} ]; then
        sed -i -e '$d'  ~/.powered_cd.log
fi
