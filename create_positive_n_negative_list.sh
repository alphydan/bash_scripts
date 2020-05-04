#!/bin/bash


OLDNRPOS=$(cat positives.dat | wc -l)
OLDNRNEG=$(cat negatives.txt | wc -l)

echo "deleting $OLDNRPOS positives.dat and $OLDNRNEG negatives.txt"
rm positives.dat;
rm negatives.txt;

for img in ./positive_images/*.png;
    do
        echo $img 1 0 0 150 150 >> positives.dat;
    done

NRPOS=$(cat positives.dat | wc -l);
echo "adding $NRPOS positive images to positives.dat";

find ./negative_images -iname "*.png" > negatives.txt

NRNEG=$(cat negatives.txt | wc -l);
echo "Added $NRNEG negative images to negatives.txt";

