mod hyprland
mod ags
mod walker
mod kitty
mod fish

default:
  just --list

setup:
    # just doesn't support module dependencies, so we have to call it manually
    @echo "{{BOLD + GREEN}}Setting up hyprland...{{NORMAL}}"
    just hyprland::setup
    @echo "{{BOLD + GREEN}}Setting up ags...{{NORMAL}}"
    just ags::setup
    @echo "{{BOLD + GREEN}}Setting up walker...{{NORMAL}}"
    just walker::setup
    @echo "{{BOLD + GREEN}}Setting up kitty...{{NORMAL}}"
    just kitty::setup
    @echo "{{BOLD + GREEN}}Setting up fish...{{NORMAL}}"
    just fish::setup
    @echo "{{BOLD + GREEN}}Done!{{NORMAL}}"
