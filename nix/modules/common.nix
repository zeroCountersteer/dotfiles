{ config, pkgs, lib, wallpaper, ... }:
let
  wall = wallpaper;
in {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.enable = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;

  time.timeZone = "Asia/Almaty";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_IE.UTF-8/UTF-8"
    ];
  };

  systemd.network.enable = false;
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  services = {
    xserver.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver.xkb = {
      layout = "us,ru";
      variant = ",";
      options = "grp:alt_shift_toggle,grp_led:scroll,terminate:ctrl_alt_bksp";
    };

    dbus.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
    settings = {
      Theme = {
        Background = "/etc/wallpapers/02.jpg";
      };
    };
  };

  environment.etc = {
    "wallpapers/02.jpg".source = wall;
  };

  systemd.user.services.kde-declarative-config = {
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig.Type = "oneshot";
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash -lc true";
  };

  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
    notoPackage = pkgs.noto-fonts;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
    plasma-browser-integration
    kdepim-runtime
  ];

  users = {
    defaultUserShell = pkgs.nushell;
    users.yuki = {
      isNormalUser = true;
      description = "yuki";
      extraGroups = [
        "wheel" "networkmanager" "dialout"
        "video" "render" "input" "audio"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [];
  };


}
