#!/bin/bash

## script linked to home dir
## ln -s /media/user/ExtraDrive1/code/bash_scripts/backitup.sh ~/backitup.sh


# Login to keybase backup user
current_user=$(keybase whoami)
if [ ${current_user} != "XXXXXX" ]
   then
       keybase login -s XXXXXX # -s for switch user
       sleep 1
fi

# Check available space
myquota=$(keybase fs quota)
USEAGE_ARRAY=( $myquota ) # convert quota string to array
myusage=$( printf "%.0f\n" ${USEAGE_ARRAY[1]} ) # rounded in GB

printf "$myusage GB currently backed up to keybase: \n"
printf " -lists\n"
printf " -books\n"
printf " -code\n"
printf " -dotfiles\n"
printf " -projects\n\n"


if [ ${myusage} -gt "220" ]
then
    printf "\n\n RUNNING OUT OF SPACE \n\n"    
fi

read -p "Continue with Backup? " -n 1 -r
echo    # move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi


# Lists & docs --> keybase
printf "\nLISTS\n"
rsync -rltvh /home/user/Documents/myname_file.pdf \
      /keybase/private/XXXXXX/Documents/myname_file.pdf

rsync -rltvh \
      --include '*.md' \
      --exclude '#*#' \
      --exclude '*~' \
      /home/user/Documents/lists/ /keybase/private/XXXXXX/Documents/lists/

# Books
printf "\nBOOKS\n"
rsync -rltvh /media/user/ExtraDrive1/books/ /keybase/private/XXXXXX/books/

# Code
printf "\nCODE\n"
rsync   -rltvh --progress\
	--exclude '*.git/' \
	--exclude '*~' \
        --include '*/' \
	\
	--include '*.py'  \
	--include '*.ipynb' \
	--include 'Pipfile' \
	\
	--include '*.csv' \
	--include '*.hdf5' \
	--include '*.edi' \
	--include '*.json' \
	--include '*.xml' \
	\
	--include '*.sh' \
	--include '*.exs' \
	--include '*.erl' \
	--include '*.elm' \
	\
	--include '*.html' \
	--include '*.htm' \
	--include '*.css' \
	--include '*.js' \
	--include '*.ttf' \
	--include '*.woff' \
	--include '*.svg' \
	--include '*.pdf' \
	\
	--include '*/img/*.jpg' \
	--include '*/img/*.jpeg' \
	--include '*/img/*.png' \
	--include '*/images/*.jpg' \
	--include '*/images/*.jpeg' \
	--include '*/images/*.png' \
	--include '*/fotos/*.jpg' \
	--include '*.gif' \
	\
	--include '*.md' \
	--include '*.txt' \
	\
	--exclude "*" \
	/media/user/ExtraDrive1/code/ /keybase/private/XXXXXX/ExtraDrive1/code/


# Dotfiles
printf "\nDOTFILES\n"
rsync -rltvh \
      --exclude '.cache' \
      --exclude '.config' \
      --exclude '.myconfig*' \
      --exclude '.emacs.d' \
      --exclude '.gnome*' \
      --exclude '.gnupg' \
      --exclude '.ipython' \
      --exclude '.local' \
      --exclude '.mozilla' \
      --exclude '.pki' \
      --exclude '.ssh' \
      --exclude '.sane' \
      --exclude '.git' \
      --exclude '.disdat' \
      --exclude '*~' \
      \
      --include '.[^.]*' \
      --include '.bash*' \
      --include '.emacs' \
      \
      --exclude '*' \
      /home/user/ /keybase/private/XXXXXX/dotfiles/


# Projects
printf "\nPROJECTS\n"
rsync -rltvh --progress \
      --exclude '.git' \
      --exclude 'real_world_projects//' \
      /media/user/ExtraDrive1/projects/ /keybase/private/XXXXXX/ExtraDrive1/projects/


# finish backups and go back to other keybase user
current_user=$(keybase whoami)
if [ ${current_user} = "XXXXXX" ]
   then
       keybase login -s XYXYXY
       sleep 1
fi

# rsync
# -n trial run
# a = archive – means it preserves permissions (owners, groups), times, symbolic links, and devices.
# r = recursive – means it copies directories and sub directories
# v = verbose – means that it prints on the screen what is being copied
# https://stackoverflow.com/questions/9952000/using-rsync-include-and-exclude-options-to-include-directory-and-file-by-pattern
