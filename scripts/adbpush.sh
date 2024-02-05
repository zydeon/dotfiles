#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: <input_file> [output folder]"
    exit -1
fi

input_path=$1
output_root=${2:-files}
output_path="${output_root}/$(basename $input_path)"
APPID=com.facebook.maestro.app  # change to your identifier

# prepare command
inner_cmd="while read line; do echo \\\$line; done > $output_path"
adbshell_cmd="run-as $APPID sh -c \"$inner_cmd\""

# execute
cat $input_path | adb shell "$adbshell_cmd"
echo "$input_path -> $output_path"
