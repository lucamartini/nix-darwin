{ pkgs, self, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
          pkgs.zsh
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      nix.extraOptions = 
      ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';

      system.defaults.finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        ShowPathbar = true;
        _FXSortFoldersFirst = true;
      };
      system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
      system.defaults.screencapture.location = "~/Screenshots";

      homebrew = {
        enable = true;
        casks = [
          "wezterm@nightly"
        ];
      };
    }