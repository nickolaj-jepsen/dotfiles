#! /bin/sh

xset s 300 5 &
if command -v xss-lock; then
    xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &
fi
