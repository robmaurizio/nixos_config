dconf.settings = {
  "org/gnome/desktop/interface" = {
    gtk-theme = "Adwaita-dark";
    color-scheme = "prefer-dark";
    show-battery-percentage = true;
  };
  
  "org/gnome/shell" = {
    favorite-apps = [
      "firefox.desktop"
      "org.gnome.Nautilus.desktop" 
      "com.spotify.Client.desktop"
    ];
  };
  
  "org/gnome/desktop/wm/keybindings" = {
    close = ["<Super>q"];
    toggle-maximized = ["<Super>m"];
  };
};
