eval (python -m virtualfish)

source ~/.config/fish/flatpak.fish

set PATH ~/.config/panel $PATH
set PATH ~/bin $PATH
set PATH ~/Development/devenv/bin $PATH
set PATH /snap/bin $PATH
set PATH /usr/bin/core_perl/ $PATH
set PATH ~/.local/bin $PATH
set PATH ~/.dotnet/tools $PATH
set PATH ~/.cargo/bin $PATH
set PATH /opt/android-sdk/tools/bin $PATH
set -g -x ANDROID_SDK_ROOT /opt/android-sdk/tools/bin

set -g -x BW_SESSION "***REMOVED***"
set -g theme_nerd_fonts yes
set -x LANG en_US.UTF-8
set LC_MESSAGES "C"
set SXHKD_SHELL sh
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
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

#set -g -x ANDROID_SDK_ROOT /home/nickolaj/Android/Sdk
#set -g -x ANDROID_AVD_HOME /home/nickolaj/.android/avd

# Alias
alias server "ssh server@ts.reasonablebravery.com"
alias p "env vblank_mode=0 primusrun"

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

bind \ca fzf_complete
thefuck --alias | source
#neofetch --ascii_distro arch --disable shell
