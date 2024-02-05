#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: <input_path> [output_folder]"
    exit -1
fi

app_id="com.facebook.maestro.app"
input_path=$1
output_root=${2:-"$HOME/Downloads"}

pull_file() {
    input_file=$1
    output_path=$2

    adb shell "run-as $app_id cat $input_file" > $output_path
}

# if directory
if adb shell "run-as $app_id [ -f $input_path ]"; then
    pull_file "$input_path" "$output_root/$(basename $input_path)"
    echo "$input_path -> $output_root/$(basename $input_path)"
else
    output_root+="/$(basename $input_path)__$(date '+%Y-%m-%d.%H:%M:%S')"
    mkdir $output_root
    for f in $(adb shell "run-as $app_id ls $input_path"); do
        pull_file "$input_path/$f" "$output_root/$f"
        echo "$input_path/$f -> $output_root/$f"
    done
fi
