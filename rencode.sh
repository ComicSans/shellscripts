#!/bin/bash

shopt -s nocaseglob

#### target directory
output="/Users/Demo/Movies/output"

mkdir $output 2> /dev/null
IFS='
'
if [ "$*" = "-v" ]; 
then
  verbose=" "
else
  verbose=" 2> /dev/null"
fi

if [ "$*" = "-r" ];
then
  recursive="-r"
else
  recursive=" "
fi

echo ---------------

echo Entering $(pwd)
for y in $(ls *.avi *.mov *.mpg *.mpeg *.mp4 *.wmv *.flv 2> /dev/null); do 
  if [ -f "$y" ]
  then

    if [ -e "$output"/"$y".avi ] ; then
	  echo --[Skipped] "$y"
    else

      echo --Processing $y
      ffmpeg -i "$y" -f avi -vcodec mpeg4 -b 600k -g 300 -bf 2 -ab 128k -acodec libmp3lame -r 24 -s 512x384 "$output"/"$y".avi $verbose
    fi
  fi
done;

for x in $(ls -d */ 2> /dev/null); do
  if [ -f "$x" ]
  then
    echo Ignoring $x
  elif [ -d "$x" ]
  then
    if [ $(pwd)/$x == $output/ ]
    then	
    	echo Skipping $x "(this is my output directory)"
    else
      if [ $recursive == "-r" ]; then
            cd $x
   	    cp ../encode .
 	    ./encode $recursive
	    rm ./encode
    	    cd ..
	    echo Leaving $x
	fi
      fi
   fi
done;

shopt -u nocaseglob

