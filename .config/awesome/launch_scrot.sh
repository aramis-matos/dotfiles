#! /bin/bash

scrot -of$1 -F "img.png" $2
xclip -selection clipboard -target image/png "img.png"
