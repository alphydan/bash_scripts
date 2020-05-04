#!/bin/bash

if [ "$1" == "-h" ]; then
    echo "ab - ab-project"
    echo "xy - xy_project"
fi

if [ "$1" == "ab" ]; then
    project_path="this-client/ab-project/"
    has_notebook=1
fi

if [ "$1" == "xy" ]; then
    project_path="that-client/xy_project/"
    has_notebook=1
fi


if [ "$1" != "-h" ]; then
    codepath="/media/user/somedrive/code"
    full_path="$codepath/$project_path"

    # Go to directory of project
    cd $full_path

    # Start environment & notebook if available
    # pipenv shell
    if [ "$has_notebook" = 1 ]; then
	pipenv run jupyter notebook --ip=0.0.0.0
    fi
fi
