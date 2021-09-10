function append_path
    if test -d $argv
        set PATH $argv $PATH
    end
end

append_path ~/.config/panel
append_path ~/bin
append_path ~/Development/devenv/bin  # billigvvs home development env
append_path /home/nij/src/devenv/bin  # billigvvs dev server development env
append_path /var/lib/snapd/snap/bin
append_path /usr/bin/core_perl/
append_path ~/.local/bin
append_path ~/.yarn/bin
append_path ~/.krew/bin
append_path /snap/bin
