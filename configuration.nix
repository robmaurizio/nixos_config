{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "wireguard" ];

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Locale
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Desktop Environment
  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Services
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.libinput.enable = true;
  xdg.portal.enable = true;

  # User account
  users.users.rob = {
    isNormalUser = true;
    description = "Robert Maurizio";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Autologin
  services.displayManager.autoLogin = {
    enable = true;
    user = "rob";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Packages
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
    # Essential tools
    wget
    curl
    git
    vim
    neovim
    
    # Applications
    bitwarden
    calibre
    copyq
    python3
    qbittorrent
    obs-studio
    joplin-desktop
    onlyoffice-bin
    wireguard-tools
    appimage-run
    
    # GNOME extras
    gnome-tweaks
    gnomeExtensions.appindicator
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  system.stateVersion = "25.05";
}
