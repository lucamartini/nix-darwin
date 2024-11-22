{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lmartini";
  home.homeDirectory = /Users/lmartini;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono"]; })
    eza
    awscli2
    php
    delta
    tree
    neovim
    tmux
    # {
    #   plugin = tmuxPlugins.mode-indicator;
    #   extraConfig = ''
    #     set -g @mode_indicator_empty_prompt ' ◇ '
    #     set -g @mode_indicator_empty_mode_style 'bg=term,fg=color2'
    #     set -g @mode_indicator_prefix_prompt ' ◈ '
    #     set -g @mode_indicator_prefix_mode_style 'bg=color2,fg=color0'
    #     set -g @mode_indicator_copy_prompt '  '
    #     set -g @mode_indicator_copy_mode_style 'bg=color3,fg=color0'
    #     set -g @mode_indicator_sync_prompt ' 󰓦 '
    #     set -g @mode_indicator_sync_mode_style 'bg=color1,fg=color0'
    #   '';
    # }
    fd
    fzf
    jq
    ripgrep
    silver-searcher
    curl
    wget
    bundletool
    cocoapods
    fastlane
    glab
    jdk8
    poppler

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    ".tmux.conf".source = ./.tmux.conf;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lmartini/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  

  programs = {
    tmux = {
      enable = true;
      # shell = "/bin/zsh";
      prefix = "C-Space";
      aggressiveResize = true;
      baseIndex = 1;
      escapeTime = 10;
      historyLimit = 50000;
      mouse = true;
      terminal = "screen-256color";
      extraConfig = ''
        set-option -g default-shell /bin/zsh
      '';
      plugins = with pkgs; [
        {    
          plugin = tmuxPlugins.mode-indicator;
          extraConfig = ''
            set -g @mode_indicator_empty_prompt ' ◇ '
            set -g @mode_indicator_empty_mode_style 'bg=term,fg=color2'
            set -g @mode_indicator_prefix_prompt ' ◈ '
            set -g @mode_indicator_prefix_mode_style 'bg=color2,fg=color0'
            set -g @mode_indicator_copy_prompt '  '
            set -g @mode_indicator_copy_mode_style 'bg=color3,fg=color0'
            set -g @mode_indicator_sync_prompt ' 󰓦 '
            set -g @mode_indicator_sync_mode_style 'bg=color1,fg=color0'
          '';
        }
        tmuxPlugins.resurrect
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
          '';
        }
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.home-manager.path = "$HOME/.config/nix-darwin";
}
