#!/bin/sh
for rom in *
do
    unzip -nqq "$rom" -d ./Unzipped
done
