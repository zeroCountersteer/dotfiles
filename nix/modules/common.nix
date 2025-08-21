{ config, pkgs, lib, ... }:
let
  wall = ../../assets/wallpapers/02.jpg;
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
  networking.wireless.enable = lib.mkForce false;

  networking.networkmanager = {
    enable = true;
    ensureProfiles = {
      profiles = {
        home = {
          connection = {
            id = "home";
            type = "wifi";
          };
          wifi = {
            ssid = "CXNK0068CF2C";
            mode = "infrastructure";
          };
          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "e6ca58bf654c9f44";
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };
      };
    };
  };

  services = {
    xserver.enable = false;
    printing.enable = true;
    desktopManager.plasma6.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    dbus.enable = true;
    greetd = {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session";
          user = "greeter";
        };
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

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

  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  environment = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [ git ];
  };
}
