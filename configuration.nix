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

  # Flatpak portals (better integration)
  xdg.portal.enable = true;

  # User
  users.users.rob = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;  # Set zsh as default shell
  };

  # Autologin
  services.displayManager.autoLogin = {
    enable = true;
    user = "rob";
  };

  # System-wide packages (CLI tools that root might need)
  environment.systemPackages = with pkgs; [
    bat
    curl
    git
    htop
    lshw
    nano
    neofetch
    pciutils
    tree
    unzip
    usbutils
    vim
    wget
    xz
    zip
  ];

  # Enable shells system-wide
  programs.zsh.enable = true;  # Required for user shell
  programs.bash.completion.enable = true;

  # Set default shell for new users
  users.defaultUserShell = pkgs.zsh;

  # Fonts (system-wide)
  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code
    fira-code-symbols
    liberation_ttf
    noto-fonts
    noto-fonts-emoji
    overpass
    roboto
    roboto-mono
    roboto-serif
  ];

  # Flathub remote
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = "flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo";
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Allow unfree globally
  nixpkgs.config.allowUnfree = true;

  # Enable locate database (useful for finding files)
  services.locate.enable = true;

  system.stateVersion = "25.05";
}
