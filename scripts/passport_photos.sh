#!/usr/bin/env bash
# Replicates a 2x2(in) passport photo into 6 copies that can be printed
# in 4x6(in) format.

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <2x2_filename>"
  exit 1
fi

input="$1"
output="${1%.*}_4x6.jpg"
montage "$1" -duplicate 5 -tile 3x2 -geometry "100%" "$output"
montage "$output" -geometry "+100+100" -background white "$output.frame.jpg"

