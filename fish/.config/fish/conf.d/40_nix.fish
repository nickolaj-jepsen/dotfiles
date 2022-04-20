if test -e ~/.nix-profile/etc/profile.d/nix.sh
  set -x NIX_PATH $NIX_PATH $HOME/.nix-defexpr/channels
  replay source ~/.nix-profile/etc/profile.d/nix.sh
  any-nix-shell fish --info-right | source
end

