if test -e ~/.nix-profile/etc/profile.d/nix.sh
  set -x NIX_PATH $NIX_PATH $HOME/.nix-defexpr/channels
  source /home/nickolaj/.nix-profile/etc/profile.d/nix.fish
#  any-nix-shell fish --info-right | source
end

