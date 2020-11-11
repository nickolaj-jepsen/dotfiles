if type -q nvim
    alias vim nvim
end

if type -q devenv
    abbr de "devenv"
    abbr shop "devenv"
    abbr flex "devenv --flex"
end

if type -q snap
    set PYCHARM_SNAP (snap list | grep 'pycharm' | awk '{ print $1 }')
    if test -n "$PYCHARM_SNAP"
        alias pycharm "snap run $PYCHARM_SNAP"
    end
end

if type -q to
    abbr z "to"
end
