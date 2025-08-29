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

    # Media & productivity
    calibre
    copyq
    joplin-desktop
    obs-studio
    onlyoffice-bin
    qbittorrent

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

    # Other useful GUI apps you might want
    # slack
    # spotify
    # vscode
  ];

  # dconf settings for GNOME apps
  dconf.settings = {
    "org/gnome/Console" = {
      custom-font = "Fira Code 11";
      ignore-scrollback-limit = true;
      audible-bell = false;
    };

    "org/gnome/nautilus/preferences" = {
      search-filter-time-type = "last_modified";
      default-folder-viewer = "list-view";
    };

    "org/gnome/control-center" = {
      last-panel = "applications";
    };

    # Disable notifications for various apps
    "org/gnome/desktop/notifications/application/org-gnome-decibels" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/org-gnome-calculator" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/org-gnome-snapshot" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/org-gnome-characters" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/com-github-hluk-copyq" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/org-gnome-evince" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/simple-scan" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/htop" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/org-gnome-loupe" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/yelp" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/org-gnome-logs" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/org-gnome-totem" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/vim" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/xterm" = {
      enable = false;
    };
    "org/gnome/desktop/notifications/application/org-gnome-weather" = {
      enable = false;
    };
  };

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

  # Firefox config - expanded with your current preferences
  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        # Privacy & Security
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "privacy.clearOnShutdown_v2.formdata" = true;

        # Telemetry & Data Collection (disable)
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.usage.uploadEnabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        # Network & DNS
        "network.dns.disableIPv6" = true;
        "network.dns.disablePrefetch" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.trr.mode" = 2;
        "network.trr.uri" = "https://dns.nextdns.io/f88fd2";
        "network.trr.custom_uri" = "https://dns.nextdns.io/f88fd2";

        # Browser behavior
        "browser.aboutConfig.showWarning" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.trending" = false;
        "browser.download.always_ask_before_handling_new_types" = true;
        "browser.compactmode.show" = true;
        "browser.startup.page" = 3; # Restore previous session

        # UI & Visual
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "browser.touchmode.auto" = false;

        # Autofill & Forms
        "signon.autofillForms" = false;
        "signon.generation.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "dom.forms.autocomplete.formautofill" = false;

        # Font preferences
        "font.name.sans-serif.x-western" = "Roboto";
        "font.name.serif.x-western" = "Roboto Serif 14pt";
        "font.name.monospace.x-western" = "Roboto Mono";
        "font.minimum-size.x-western" = 9;
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
