{ config, pkgs, ... }:
{
  home.username = "yuki";
  home.homeDirectory = "/home/yuki";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.nushell.enable = true;
  programs.git.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.size = 14;
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
        "privacy.donottrackheader.enabled" = true;
        };
    };
  };

  home.packages = with pkgs; [
    kicad
    kicadAddons.kikit
    kicadAddons.kikit-library
    freerouting
    freecad
    github-desktop
    kdePackages.kate
    firefox
    thunderbird
    ripgrep
    fd
    jdk17
    jre8
    PrismLauncher-Cracked
  ];
}
