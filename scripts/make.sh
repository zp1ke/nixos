
if [ -z "$1" ]; then
  echo "Enter command! (update, clean)"
  exit 1
fi

case "$1" in
  update)
    nix flake update
    sudo cp -f ./config.nix /etc/nixos/config.nix
    sudo nixos-rebuild switch
    home-manager switch --flake .#zp1ke
    ;;
  clean)
    nix-collect-garbage -d
    ;;
  *)
    echo "Unknown command! (must be one of: update, clean)"
    ;;
esac
