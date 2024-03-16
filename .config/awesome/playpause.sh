#!/bin/bash


if [[ $(playerctl status) == "Playing" ]] 
then playerctl pause -a
else playerctl play -a
fi
