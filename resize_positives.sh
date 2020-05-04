find ./positive_images/ -type f -iname "*.png" | while read f;
do
    # extract dimensions of the image (-ping to speed up and not load into memory)
    height=$(identify -ping -format "%[fx:w]x%[fx:h]" $f  | cut -dx -f2)
    width=$(identify -ping -format "%[fx:w]x%[fx:h]" $f  | cut -dx -f1)
    siz=$( stat -c %s $f); #filesize
    printf "\n"
    echo $height, " x ", $width, " -> ", $siz
        echo "resizing to 40 x 40", $f
        convert $f -resize 40x40 $f
        pngcrush -reduce -rem allb -q -brute -oldtimestamp $f;
done
