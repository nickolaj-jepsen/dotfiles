# start X at login
#if status --is-login
#    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
#        Hyprland
#        exec startx -- -keeptty
#    end
#end
