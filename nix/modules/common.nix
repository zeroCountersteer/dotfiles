{ config, pkgs, lib, ... }:
let
  wall = ../../assets/wallpapers/02.jpg;
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };
  nix.optimise.automatic = true;

  time.timeZone = "Asia/Almaty";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_NUMERIC = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_COLLATE = "en_US.UTF-8";
  };
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "en_IE.UTF-8/UTF-8"
  ];

  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.yuki = {
    isNormalUser = true;
    description = "yuki";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
  };
  users.defaultUserShell = pkgs.nushell;

  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  services.displayManager.defaultSession = "plasmax11";

  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.slick.enable = true;
    greeters.slick.extraConfig = ''
      background=${builtins.toString wall}
      logind-check-graphical=true
    '';
  };

  programs.hyprland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.desktopManager.plasma6.enable = true;

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    XDG_SESSION_TYPE = "wayland";
    XCURSOR_SIZE = "24";
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  home-manager.users.yuki = {
    programs.plasma.enable = true;
    programs.plasma.workspace.wallpaper = wall;
  };
}
