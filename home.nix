{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "rob";
  home.homeDirectory = "/home/rob";

  # This value determines the Home Manager release which your configuration is
  # compatible with. Don't change this unless you know what you're doing!
  home.stateVersion = "25.05";

  # Flatpak apps will be installed manually after first boot

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Robert Maurizio";
    userEmail = "your.email@example.com"; # Update this with your email
  };

  # Firefox configuration
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        name = "Default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://start.duckduckgo.com";
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;
        };
      };
    };
  };

  # Shell configuration
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Add any custom bash configuration here
    '';
  };

  # GTK theme for better integration
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # QT theme to match GTK
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # Enable XDG directories
  xdg.enable = true;
}
