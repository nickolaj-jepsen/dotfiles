set PATH ~/.config/panel $PATH
set PATH ~/bin $PATH
set PATH ~/Development/devenv/bin $PATH
set PATH /var/lib/snapd/snap/bin $PATH
set PATH /usr/bin/core_perl/ $PATH
set PATH ~/.local/bin $PATH

set -x LANG en_US.UTF-8
set LC_MESSAGES "C"
set SXHKD_SHELL sh
set -g -x AO_USER nij

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
    end
end

set -g -x _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
set -g -x _JAVA_AWT_WM_NONREPARENTING 1
set -g -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell"
    source "$BASE16_SHELL/profile_helper.fish"
end

bind \ca fzf_complete
