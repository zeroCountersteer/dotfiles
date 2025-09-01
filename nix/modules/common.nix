{ config, pkgs, lib, ... }:
let
  wall = ../../assets/wallpapers/02.jpg;
  kdeDir = ../../assets/kde;
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
        "Far far away" = {
          connection = {
            id = "Far far away";
            type = "wifi";
          };
          wifi = {
            ssid = "Far far away";
            mode = "infrastructure";
          };
          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "bluetooth";
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

    "kde/kdeglobals".text = ''
[ColorEffects:Disabled]
ChangeSelectionColor=
Color=56,56,56
ColorAmount=0
ColorEffect=0
ColorEffectAmount=0
ColorEffectType=0
ContrastAmount=0.65
ContrastEffect=0
ContrastEffectAmount=0.65
Enable=false
IntensityAmount=0
IntensityEffect=0
IntensityEffectAmount=0
IntensityEffectType=0
[ColorEffects:Inactive]
ChangeSelectionColor=
Color=112,111,110
ColorAmount=0.025
ColorEffect=0
ColorEffectAmount=0
ColorEffectType=0
ContrastAmount=0.1
ContrastEffect=0
ContrastEffectAmount=0.65
Enable=false
IntensityAmount=0
IntensityEffect=0
IntensityEffectAmount=0
IntensityEffectType=0
[Colors:Button]
BackgroundAlternate=239,240,241
BackgroundNormal=239,240,241
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=136,138,133
ForegroundLink=0,87,174
ForegroundNegative=191,3,3
ForegroundNeutral=176,128,0
ForegroundNormal=35,38,41
ForegroundPositive=0,110,40
ForegroundVisited=104,34,139
[Colors:Selection]
BackgroundAlternate=61,174,233
BackgroundNormal=61,174,233
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=239,240,241
ForegroundLink=85,170,255
ForegroundNegative=252,164,164
ForegroundNeutral=255,221,154
ForegroundNormal=239,240,241
ForegroundPositive=165,214,167
ForegroundVisited=211,160,253
[Colors:Tooltip]
BackgroundAlternate=239,240,241
BackgroundNormal=239,240,241
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=136,138,133
ForegroundLink=0,87,174
ForegroundNegative=191,3,3
ForegroundNeutral=176,128,0
ForegroundNormal=35,38,41
ForegroundPositive=0,110,40
ForegroundVisited=104,34,139
[Colors:View]
BackgroundAlternate=252,252,252
BackgroundNormal=252,252,252
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=136,138,133
ForegroundLink=0,87,174
ForegroundNegative=191,3,3
ForegroundNeutral=176,128,0
ForegroundNormal=49,54,59
ForegroundPositive=0,110,40
ForegroundVisited=104,34,139
[Colors:Window]
BackgroundAlternate=239,240,241
BackgroundNormal=239,240,241
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=136,138,133
ForegroundLink=0,87,174
ForegroundNegative=191,3,3
ForegroundNeutral=176,128,0
ForegroundNormal=35,38,41
ForegroundPositive=0,110,40
ForegroundVisited=104,34,139
[General]
ColorScheme=Breeze
Name=Breeze
XftAntialias=true
XftHintStyle=hintslight
XftSubPixel=none
fixed=Hack,10,-1,5,50,0,0,0,0,0
font=Noto Sans,10,-1,5,50,0,0,0,0,0
menuFont=Noto Sans,10,-1,5,50,0,0,0,0,0
smallestReadableFont=Noto Sans,8,-1,5,50,0,0,0,0,0
toolBarFont=Noto Sans,10,-1,5,50,0,0,0,0,0
[Icons]
Theme=breeze
[KDE]
LookAndFeelPackage=org.kde.breeze.desktop
[WM]
activeBackground=61,174,233
activeBlend=239,240,241
activeForeground=252,252,252
inactiveBackground=239,240,241
inactiveBlend=239,240,241
inactiveForeground=136,138,133
'';

    "kde/kglobalshortcutsrc".text = ''
[ActivityManager]
_k_friendly_name=Activity Manager
switch-to-activity-1bc2683f-4c0d-495f-ba28-7fc16712228b=none,none,Switch to activity "Default"
switch-to-next-activity=Meta+Tab,none,Switch to Next Activity
switch-to-previous-activity=Meta+Shift+Tab,none,Switch to Previous Activity
[ksmserver]
Halt Without Confirmation=Meta+Shift+Q,none,Shut Down Without Confirmation
Logout=Ctrl+Alt+Del,none,Show Logout Prompt
[kwin]
Expose=Meta+W,Meta+F9,Toggle Present Windows (Current Desktop)
ShowDesktop=Meta+D,Meta+D,Show Desktop
Switch One Desktop Down=Meta+Page_Down,none,Switch One Desktop Down
Switch One Desktop Up=Meta+Page_Up,none,Switch One Desktop Up
Switch One Desktop to the Left=Meta+Left,none,Switch One Desktop to the Left
Switch One Desktop to the Right=Meta+Right,none,Switch One Desktop to the Right
ViewZoomIn=Meta+=,Meta+=,Zoom In
ViewZoomOut=Meta+-,Meta+-,Zoom Out
Window Close=Alt+F4,Alt+F4,Close Window
Window Fullscreen=Meta+F11,Meta+F11,Make Window Fullscreen
Window Maximize=Meta+Up,Meta+Up,Maximize Window
Window Minimize=Meta+Down,Meta+Down,Minimize Window
activate task manager entry 1=Meta+1,Meta+1,Activate Task Manager Entry 1
activate task manager entry 2=Meta+2,Meta+2,Activate Task Manager Entry 2
activate task manager entry 3=Meta+3,Meta+3,Activate Task Manager Entry 3
activate task manager entry 4=Meta+4,Meta+4,Activate Task Manager Entry 4
activate task manager entry 5=Meta+5,Meta+5,Activate Task Manager Entry 5
activate task manager entry 6=Meta+6,Meta+6,Activate Task Manager Entry 6
activate task manager entry 7=Meta+7,Meta+7,Activate Task Manager Entry 7
activate task manager entry 8=Meta+8,Meta+8,Activate Task Manager Entry 8
[plasma-desktop]
_k_friendly_name=Plasma
show dashboard=Meta+``,none,Show Desktop Grid
[services]
_k_friendly_name=Services
'';

    "kde/kded5rc".text = ''
[Module-device_automounter]
autoload=false
'';

    "kde/ksplashrc".text = ''
[KSplash]
Engine=none
Theme=None
'';

    "kde/kwinrc".text = ''
[Desktops]
Id_1=ea7f8420-e1b9-44bf-93db-c9fcba112200
Number=1
Rows=1
[Effect-slide]
HorizontalGap=0
[Plugins]
slideEnabled=true
[Windows]
BorderlessMaximizedWindows=true
'';

    "kde/plasma-org.kde.plasma.desktop-appletsrc".text = ''
[ActionPlugins][0]
MiddleButton;NoModifier=org.kde.paste
RightButton;NoModifier=org.kde.contextmenu
[Containments][1][Wallpaper][org.kde.image][General]
Image=file:///etc/wallpapers/02.jpg
FillMode=pad
Blur=true
'';

    "systemd/user/kde-declarative-config.service".text = ''
[Unit]
Description=Apply declarative KDE config
After=graphical-session.target
Wants=graphical-session.target

[Service]
Type=oneshot
ExecStart=${pkgs.bash}/bin/bash -lc '
  mkdir -p "$HOME/.config"
  ln -sf /etc/kde/kdeglobals "$HOME/.config/kdeglobals"
  ln -sf /etc/kde/kglobalshortcutsrc "$HOME/.config/kglobalshortcutsrc"
  ln -sf /etc/kde/kded5rc "$HOME/.config/kded5rc"
  ln -sf /etc/kde/ksplashrc "$HOME/.config/ksplashrc"
  ln -sf /etc/kde/kwinrc "$HOME/.config/kwinrc"
  ln -sf /etc/kde/plasma-org.kde.plasma.desktop-appletsrc "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
'
[Install]
WantedBy=graphical-session.target
'';
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
      QT_QPA_PLATFORM = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [];
  };


}
