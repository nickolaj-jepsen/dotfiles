set -x LANG en_US.UTF-8
set LC_MESSAGES "C"
set SXHKD_SHELL sh
set -g -x AO_USER nij

# set -g -x _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
set -g -x _JAVA_AWT_WM_NONREPARENTING 1
set -g -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

set -g -x EDITOR nvim
set -g -x PAGER less
