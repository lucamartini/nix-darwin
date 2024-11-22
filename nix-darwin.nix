{ pkgs, self, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 
      pkgs.zsh
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

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
  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      extraFlags = [
        "--verbose"
      ];
    };
    global = {
      autoUpdate = false;
    };
    brews = [
      "pulumi"
    ];
    casks = [
      "wezterm@nightly"
    ];
  };
}