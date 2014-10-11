#!/bin/sh

for i in `seq 4`
do
	HandBrakeCLI -i /dev/cdrom -t $i --encoder x264 --format mp4 --quality 20 --x264-tune film --x264-profile baseline --vfr --audio 1,2 --aencoder faac,copy:ac3 --deinterlace fast --markers --optimize -o $(basename $1 .iso)$i.m4v
done
