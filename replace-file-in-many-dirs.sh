#!/bin/bash
for dir in $(ls -d /home/*)
do
    cp [your file] "${dir}"/
done
