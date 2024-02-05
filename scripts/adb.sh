#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: <program> [arg1] [arg2] ...."
    exit -1
fi

cmd_args="$@"
adb shell "run-as com.facebook.maestro.app $cmd_args"
