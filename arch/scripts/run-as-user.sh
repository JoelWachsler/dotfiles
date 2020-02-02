#!/usr/bin/env python

import argparse
from arch.util import cmd

parser = argparse.ArgumentParser(description='Utility script used to run another script as the provided user. This script will also automatically cd into the home folder of the provided user.')
parser.add_argument('user', help='The user to run the script as')
parser.add_argument('script', help='The script to run')
args = parser.parse_args()

user = args.user
script = args.script
cmd(f'su {user} -P -c "cd /home/{user} && ./{script}"')
