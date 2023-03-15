#!/bin/bash

#- Count “image” length
#- Print an image name in the image list if the resolution is square

image_Length=$(cat image.json | jq '.Image | length')
echo "The image Length: $image_Length"
echo "Name the image is square shape: "
for((i=0;i<$image_Length;i++)); do
    o_hoffset=$(cat image.json | jq '.Image['$i'].hoffset')
    o_woffset=$(cat image.json | jq '.Image['$i'].woffset')
    if [[ $o_hoffset -eq $o_woffset ]]
    then
        echo $(cat image.json | jq '.Image['$i'].name')
    else
        continue
    fi
done

