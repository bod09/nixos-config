{ config, pkgs, theme, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bod";
  home.homeDirectory = "/home/bod";

  imports = [
    ./modules/waybar.nix
    ./modules/hyprpaper.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neovim
    fastfetch
    pavucontrol
    nerd-fonts.jetbrains-mono
    nwg-look
    swaynotificationcenter
    vesktop
    protonplus
    vscodium
    networkmanagerapplet
  ];

  # Programs
  programs.waybar = {
    enable = true;
  };
  programs.kitty.enable = true;
  programs.rofi = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "bod09";
  };
  programs.lazygit.enable = true;
  programs.brave = {
    enable = true;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "dphilobhebphkdjbpfohgikllaljmgbn"; } # Simplelogin
      { id = "oldceeleldhonbafppcapldpdifcinji"; } # LanuageTool
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
      { id = "gebbhagfogifgggkldgodflihgfeippi"; } # Return YouTube Dislike
    ];
    commandLineArgs = [ #brave://flags
      "--disable-features=NativeBraveWallet"
      "--disable-features=BraveAiChat"
    ];
  };

  #catppuccin
  catppuccin = {
    enable = true;
    flavor = "mocha";
    # waybar.enable = true;
    # rofi.enable = true;
    # kitty.enable = true;
  };

  # Hyprland fixing theme issues
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

 # Hyprland fixing systemd startup
  wayland.windowManager.hyprland.systemd.enable = false;

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
