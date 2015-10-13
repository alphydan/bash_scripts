#!/bin/bash

echo "...........JPG RESIZING.........."

find -type f -iname "*.jpg" | while read f; do

    # extract dimensions of the image (-ping to speed up and not load into memory)
    height=$(identify -ping -format "%[fx:w]x%[fx:h]" $f  | cut -dx -f2)
    width=$(identify -ping -format "%[fx:w]x%[fx:h]" $f  | cut -dx -f1)
    siz=$( stat -c %s $f); #filesize
    printf "\n\n"
    echo $height, " x ", $width, " -> ", $siz

    if [ "$siz" -lt "120000" ] #smaller than 100Kb
        # Compress at 95% (jpg) / lossless compression (PNG)
        then
        echo "Compressing small file at 95%:", $f;
        #-o: overwrite, -p:preserve modification times
        jpegoptim -m95 --strip-all -p -o $f
     elif [ "$siz" -ge "120000" ]
        then
        if [ "$width" -lt "1000" ] && [ "$height" -lt "1000" ]
            # larger filesize, but small width & height
            then
            echo "Compressing small file at 85%"
            jpegoptim -m85 --strip-all -p -o $f
        elif [ "$width" -ge "1000" ] || [ "$height" -ge "1000" ]
            then
            # if any of the dimensions are greater than 1000 resize
            echo "reducing image to 900px size & compressing at 85%"
            convert $f -resize 950x950\> $f #only convert if it is bigger
            jpegoptim -m90 --strip-all -p -o $f
        fi
      fi
done

printf "\n\n"
echo "...........PNG RESIZING.........."
printf "\n"

find -type f -iname "*.png" | while read f; do

    # extract dimensions of the image (-ping to speed up and not load into memory)
    height=$(identify -ping -format "%[fx:w]x%[fx:h]" $f  | cut -dx -f2)
    width=$(identify -ping -format "%[fx:w]x%[fx:h]" $f  | cut -dx -f1)
    siz=$( stat -c %s $f); #filesize
    printf "\n\n"
    echo $height, " x ", $width, " -> ", $siz

    if [ "$siz" -lt "120000" ] #smaller than 100Kb
        # Compress at 95% (jpg) / lossless compression (PNG)
        then
        echo "Compressing small file losselessly", $f;
        pngcrush -reduce -rem allb -q -brute -oldtimestamp $f;
     elif [ "$siz" -ge "120000" ]
        then
        if [ "$width" -lt "1000" ] && [ "$height" -lt "1000" ]
            # larger filesize, but small width & height
            then
            echo "Compressing losslessly medium image", $f
            pngcrush -reduce -rem allb -q -brute -oldtimestamp $f;
        elif [ "$width" -ge "1000" ] || [ "$height" -ge "1000" ]
            then
            # if any of the dimensions are greater than 1000 resize
            echo "reducing image to 900px size & compressing at 85%", $f
            convert $f -resize 950x950\> $f #only convert if it is bigger
            pngcrush -reduce -rem allb -q -brute -oldtimestamp $f;
        fi
      fi
done


# ref http://www.imagemagick.org/Usage/resize/
