{ config, pkgs, inputs ? {}, ... }:

{
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Set home directory and user
  home.username = "rob";
  home.homeDirectory = "/home/rob";

  # User packages - mostly GUI apps and user-specific tools
  home.packages = with pkgs; [
    # Password managers
    _1password-gui
    bitwarden

    # Media & productivity
    calibre
    copyq
    joplin-desktop
    obs-studio
    onlyoffice-bin
    qbittorrent
    slack
    spotify
    vscode
    
    # Development (user-specific)
    nodejs
    python3
    
    # Utilities
    appimage-run
    
    # GNOME extras
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.pop-shell
    
  ];

  # Git setup - you can expand this with more config
  programs.git = {
    enable = true;
    userName = "Rob";
    userEmail = "rob@maurizio.ooo";
    
    # Add some useful git config
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "vim";
    };
    
    # Maybe add some aliases
    aliases = {
      br = "branch";
      co = "checkout";
      st = "status";
    };
  };

  # Shell setup - let your dotfiles handle this instead
  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = true;
  #   autosuggestion.enable = true;
  #   syntaxHighlighting.enable = true;
  #   
  #   # Let your dotfiles handle aliases and custom config
  #   # Don't duplicate stuff here if your dotfiles already do it
  #   
  #   # Oh My Zsh if you want it (optional)
  #   # oh-my-zsh = {
  #   #   enable = true;
  #   #   theme = "robbyrussell";
  #   #   plugins = [ "git" "sudo" "docker" ];
  #   # };
  # };

  # Firefox config - you can expand this a lot
  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
        "privacy.resistFingerprinting" = true;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.tabs.warnOnClose" = false;
      };
      # Extensions (now available through flake inputs)
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        multi-account-containers
        noscript
        ublock-origin
        # joplin-web-clipper  # uncomment if available
        # linkding-extension  # uncomment if available
      ];
    };
  };

  # Terminal emulator config if you don't like GNOME Terminal
  # programs.alacritty = {
  #   enable = true;
  #   settings = {
  #     colors.primary.background = "#1d1f21";
  #     font.size = 11.0;
  #   };
  # };

  # VS Code if you use it
  # programs.vscode = {
  #   enable = true;
  #   extensions = with pkgs.vscode-extensions; [
  #     bbenoist.nix
  #     ms-python.python
  #   ];
  # };

  # Direnv for project-specific environments
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Maybe configure some other programs you use
  # programs.tmux = {
  #   enable = true;
  #   # Add tmux config here
  # };

  # XDG directories and dotfiles management
  xdg.enable = true;
  
  # Link your existing dotfiles
  # Example: if you have a ~/.zshrc you want to manage
  # home.file.".zshrc".source = ./dotfiles/zshrc;
  
  # For XDG config files (stuff that goes in ~/.config/)
  # xdg.configFile."alacritty/alacritty.yml".source = ./dotfiles/alacritty.yml;
  # xdg.configFile."nvim".source = ./dotfiles/nvim;  # whole directories work too
  
  # OBS dotfiles (if you have them)
  # xdg.configFile."obs-studio" = {
  #   source = ./dotfiles/obs-studio;
  #   recursive = true;
  # };

  # Font configuration (user-specific fonts)
  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with
  home.stateVersion = "24.05";  # Match your system version
}
