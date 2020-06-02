#!/bin/bash

#short name = (short-name long-name "-->" directory 1:has jupyter notebook)
# this file is symlinked from the home
# ln -s /media/user/ExtraDrive1/code/start-os/startcoding.sh ~/startcoding.sh

ab=("ab" "ab-report" "-->" "tuab-code/ab-report/" 1)
xa=("xa" "xa-trading" "-->" "tuab-code/xa-trading/" 1)
toad=("toad" "toad-code" "-->" "toad-code/" 0)
joy=("joy" "ligo-joy-division" "-->" "toad-code/1.product/experiments/ligo-joy-division/" 1)

# help flag: display project details
if [ "$1" == "-h" ]; then
    echo ${ab[@]}
    echo ${xa[@]}
    echo ${toad[@]}
fi

# otherwise, identify project 
if [ "$1" != "-h" ]; then

    if [ "$1" == "ab" ]; then
	project_path=${ab[3]}
	has_notebook=${ab[4]}
    elif [ "$1" == "xa" ]; then
	project_path=${xa[3]}
	has_notebook=${xa[4]}
    elif [ "$1" == "toad" ]; then
	project_path=${toad[3]}
	has_notebook=${toad[4]}
    elif [ "$1" == "joy" ]; then
	project_path=${joy[3]}
	has_notebook=${joy[4]}
    else
	echo "project not found"
    fi

    
    codepath="/media/user/ExtraDrive1/code"
    full_path="$codepath/$project_path"

    # Go to directory of project
    cd $full_path

    # Start environment & notebook if available
    # pipenv shell
    if [ "$has_notebook" = 1 ]; then
	pipenv run jupyter notebook # --ip=0.0.0.0
    fi
fi
