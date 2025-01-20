mod hyprland

export DISTRO := if `command -v apt-get` =~ 'apt' { 
    "debian" 
} if `command -v pacman` =~ 'pacman' {
    "arch"
} else {
    "unknown"
}

default:
    just --list
