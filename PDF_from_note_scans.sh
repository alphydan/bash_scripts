#!/bin/bash

echo "...........JPG Processing.........."

find -type f -iname "*.jpg" | while read f; do

    # extract dimensions of the image (-ping to speed up and not load into memory)
    height=$(identify -ping -format "%[fx:w]x%[fx:h]" $f  | cut -dx -f2)
    width=$(identify -ping -format "%[fx:w]x%[fx:h]" $f  | cut -dx -f1)
    siz=$( stat -c %s $f); #filesize
    printf "\n\n"
    echo $height, " x ", $width, " -> ", $siz

    convert $f -resize 80% -brightness-contrast 15x1 small_`basename $f .jpg`.jpg;


done

echo "........ Converting to PDF - 80% compression ......"

convert -quality 90 `find -type f -name 'small*.jpg' | sort -V` output.pdf

echo " .... cleaning up small files ..."
rm small*
