nix flake update
darwin-rebuild switch --flake .config/nix-darwin

nix-env --list-generations
darwin-rebuild --list-generations

sudo nix-collect-garbage -d

