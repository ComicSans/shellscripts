#!/bin/sh

dd if=$1 | pv -s `gdu -b -c $1  | cut -f 1 -d " " | head -1` | dd of=$2
