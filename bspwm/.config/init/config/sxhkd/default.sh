#! /bin/sh

export SXHKD_SHELL=bash
PATH=$PATH:~/bin
sxhkd -r ~/tmp/sxhkd.log -m 1 &
