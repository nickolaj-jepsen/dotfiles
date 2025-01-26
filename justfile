mod hyprland
mod astal
mod walker
mod ghostty
mod fish

default:
  just --list

setup:
    # just doesn't support module dependencies, so we have to call it manually
    @echo "{{BOLD + GREEN}}Setting up hyprland...{{NORMAL}}"
    just hyprland::setup
    @echo "{{BOLD + GREEN}}Setting up astal...{{NORMAL}}"
    just astal::setup
    @echo "{{BOLD + GREEN}}Setting up walker...{{NORMAL}}"
    just walker::setup
    @echo "{{BOLD + GREEN}}Setting up ghostty...{{NORMAL}}"
    just ghostty::setup
    @echo "{{BOLD + GREEN}}Setting up fish...{{NORMAL}}"
    just fish::setup
    @echo "{{BOLD + GREEN}}Done!{{NORMAL}}"
