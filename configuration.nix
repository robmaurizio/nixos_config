{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Basic system config
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Desktop
  services.xserver.enable = true;
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

  # Basic services
  services.flatpak.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;

  # User
  users.users.rob = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Autologin
  services.displayManager.autoLogin = {
    enable = true;
    user = "rob";
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Basic tools
    git
    vim
    
    # Applications
    firefox
    _1password-gui
    bitwarden
    calibre
    copyq
    python3
    qbittorrent
    obs-studio
    joplin-desktop
    onlyoffice-bin
    appimage-run
    
    # GNOME extras
    gnome-tweaks
    gnomeExtensions.appindicator
  ];

  # Flathub remote
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = "flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo";
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
