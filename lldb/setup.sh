#!/usr/bin/env bash

PYTHON_PKG="/Library/Python/2.7/site-packages"

rm -rf $HOME/.lldbinit
rm -rf $PYTHON_PKG/lldbinit.py

ln -s $PWD/lldbinit $HOME/.lldbinit
sudo ln -s $PWD/lldbinit.py $PYTHON_PKG/lldbinit.py
