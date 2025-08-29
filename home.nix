{ config, pkgs, inputs ? {}, ... }:

{
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Set home directory and user
  home.username = "rob";
  home.homeDirectory = "/home/rob";

  #######################
  # Packages to Install #
  #######################
  home.packages = with pkgs; [
    _1password-gui
    appimage-run
    calibre
    copyq
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.pop-shell
    inotify-tools
    joplin-desktop
    nodejs
    obs-studio
    onlyoffice-bin
    python3
    qbittorrent
    slack
    spotify
    vscode
  ];

  ##################################
  # dconf settings for GNOME apps  #
  ##################################
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

    "org/gnome/shell/weather" = {
      automatic-location = true;
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      speed = 0.170940170940171;
      natural-scroll = false;
    };

    "org/gnome/desktop/screen-time-limits" = {
      daily-limit-enabled = false;
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [
        "org.gnome.Epiphany.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.Software.desktop"
        "org.gnome.seahorse.Application.desktop"
      ];
    };

    "org/gnome/desktop/screensaver" = {
      lock-enabled = true;
      lock-delay = 120;
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/sound" = {
      event-sounds = true;
    };

    "org/gnome/desktop/interface" = {
      font-antialiasing = "rgba";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,close";
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "com.onepassword.OnePassword.desktop" 
        "bitwarden.desktop"
        "firefox.desktop"
        "org.gnome.Geary.desktop"
        "joplin.desktop"
        "com.obsproject.Studio.desktop"
        "com.spotify.Client.desktop"
        "com.slack.Slack.desktop"
      ];
      enabled-extensions = [ "pop-shell@system76.com", "appindicatorsupport@rgcjonas.gmail.com" ];
      allow-extension-installation = true;
    };

    "org/gnome/shell/extensions/pop-shell" = {
      tile-by-default = false;
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };

    # Disable notifications for various apps
    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      show-banners = false;
      enable = false;
    };
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

  ################################################
  # Git setup - can expand this with more config
  ################################################
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
  };

  ##############################################
  # Shell setup - let your dotfiles handle this instead
  ##############################################
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

  #######################################################
  # Firefox config - split prefs: Nix settings + user.js
  #######################################################
  programs.firefox = {
    enable = true;

    profiles.default = {
      name = "Default";

      # Declarative prefs that are easy to manage in Nix
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

      # Extensions
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        multi-account-containers
        noscript
        ublock-origin
        joplin-web-clipper
        linkding-extension
      ];
    };
  };

  # Add user.js for the "giant JSON / UI layout" prefs
  xdg.configFile."mozilla/firefox/default/user.js".source = ./firefox-user.js;

  ########################
  # VS Code
  ########################
  # programs.vscode = {
  #   enable = true;
  #   extensions = with pkgs.vscode-extensions; [
  #     bbenoist.nix
  #     ms-python.python
  #   ];
  # };

  #########################################
  # Direnv for project-specific environments
  #########################################
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  ##################
  # Custom Scripts #
  ##################
  home.file."config-watch-diff.sh" = {
    target = ".local/bin/config-watch-diff.sh";
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # config-watch-diff.sh
      #
      # Watches a config directory for changes and shows diffs.
      #
      # Usage examples:
      #   config-watch-diff.sh firefox
      #   config-watch-diff.sh ~/.mozilla/firefox
      #   config-watch-diff.sh obs-studio

      APP="$1"

      if [[ -z "$APP" ]]; then
        echo "Usage: $0 <app-name-or-path>"
        exit 1
      fi

      # Determine config directory
      case "$APP" in
        # Special cases
        firefox)
          CONF_DIR="$HOME/.mozilla/firefox"
          ;;
        *)
          # If input looks like a path, resolve it
          if [[ "$APP" = /* || "$APP" = ~* || "$APP" = .* ]]; then
            CONF_DIR=$(realpath "$APP")
          else
            CONF_DIR="$HOME/.config/$APP"
          fi
          ;;
      esac

      if [ ! -d "$CONF_DIR" ]; then
        echo "Config directory $CONF_DIR not found"
        exit 1
      fi

      echo "Watching $CONF_DIR for changes..."
      echo "Press Ctrl+C to stop."

      # Temporary directory for storing snapshots
      SNAP_DIR=$(mktemp -d)

      # Function to snapshot current state of files
      snapshot() {
        find "$CONF_DIR" -type f | while read -r file; do
          cp "$file" "$SNAP_DIR/$(echo "$file" | tr '/' '_')" 2>/dev/null
        done
      }

      # Initial snapshot
      snapshot

      # Start watching for changes
      inotifywait -m -r -e modify,create,delete,move "$CONF_DIR" --format '%w%f %e' | while read FILE EVENT; do
        SNAP_FILE="$SNAP_DIR/$(echo "$FILE" | tr '/' '_')"

        echo
        echo "🔄 Change detected: $FILE ($EVENT)"

        if [[ "$EVENT" == *"MODIFY"* ]] && [ -f "$FILE" ]; then
          if [ -f "$SNAP_FILE" ]; then
            echo "---- diff ----"
            diff -u "$SNAP_FILE" "$FILE" || echo "(no textual diff or binary file)"
            echo "--------------"
          fi
          cp "$FILE" "$SNAP_FILE"
        elif [[ "$EVENT" == *"CREATE"* ]]; then
          echo "New file created: $FILE"
          cp "$FILE" "$SNAP_FILE"
        elif [[ "$EVENT" == *"DELETE"* ]]; then
          echo "File deleted: $FILE"
          rm -f "$SNAP_FILE"
        fi
      done
    '';
  };


  ####################################
  # XDG directories and dotfiles management
  ####################################
  xdg.enable = true;

  ############################
  # Link your existing dotfiles
  ############################
  # Example: if you have a ~/.zshrc you want to manage
  # home.file.".zshrc".source = ./dotfiles/zshrc;

  ##################################################
  # For XDG config files (stuff that goes in ~/.config/)
  ##################################################
  # xdg.configFile."alacritty/alacritty.yml".source = ./dotfiles/alacritty.yml;
  # xdg.configFile."nvim".source = ./dotfiles/nvim;  # whole directories work too

  ################################
  # OBS dotfiles
  ################################
  # xdg.configFile."obs-studio" = {
  #   source = ./dotfiles/obs-studio;
  #   recursive = true;
  # };

  ##########################################
  # Font configuration (user-specific fonts)
  ##########################################
  fonts.fontconfig.enable = true;

  ####################################################
  # This value determines the Home Manager release that your
  # configuration is compatible with
  ####################################################
  home.stateVersion = "25.11";
}
