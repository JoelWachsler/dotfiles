#!/usr/bin/env bash

read -p 'Input email: ' email
ssh-keygen -t rsa -b 4096 -C "$email"
ssh-add
