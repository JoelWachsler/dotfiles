#!/usr/bin/env bash

# Just to be sure
rm -rf dislocker

git clone https://github.com/Aorimn/dislocker.git
cd dislocker
cmake .
sudo make install

# Cleanup
cd ..
rm -rf dislocker