#!/bin/bash
find /mnt/* \(  -name ".DS_Store" \
                -or -name ".TemporaryItems" \
                -or -name ".Trashes" \
                -or -name "._*" \
                -or -name ".apdisk" \) \
                -exec rm -r "{}" \;
