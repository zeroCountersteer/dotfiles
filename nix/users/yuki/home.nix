{ config, pkgs, wallpaper, font, monoFont, ... }:
{

  home.username = "yuki";
  home.homeDirectory = "/home/yuki";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

home.packages = with pkgs; [
  github-desktop
  kdePackages.kate
  kdePackages.kiten
  kdePackages.dolphin
  kdePackages.kwalletmanager
  qbittorrent
  thunderbird
  fuzzel
  iosevka-bin
  ibm-plex
  discord-ptb
  git
  nil
  kicad
  kicadAddons.kikit
  freerouting
  freecad
  diylc
  octaveFull
  qucs-s
  osu-lazer-bin
  retroarch-full
  pcsx2
  lutris
  ripgrep
  fd
  fastfetch
  miraclecast
  openocd
  stlink
  dfu-util
  arduino-cli
  stm32cubemx
  esptool
  gcc
  gdb
  lldb
  cmake
  ninja
  pkg-config
  valgrind
  bear
  gnumake
  binutils
  lld
  mold
  rustup
  sccache
  qt6Packages.qtbase
  qt6Packages.qtdeclarative
  qt6Packages.qtshadertools
  qt6Packages.qtcharts
  qt6Packages.qt5compat
  qt6Packages.qtwayland
  openssl
  zlib
  pulseaudio
  libxkbcommon
  wayland
  xorg.libX11
  xorg.libXcursor
  xorg.libXrandr
  xorg.libXi
  xorg.libXext
  libGL
  libGLU
  mesa
  vulkan-loader
  libglvnd
  sdl3
  sdl3.dev
  sdl3-ttf
  sdl3-image
];

  programs.nushell.enable = true;

  programs.nushell.extraConfig = ''
    $env.config = {
      show_banner: false
    }
  '';

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font = {
        normal = { family = monoFont; style = "Regular"; };
        bold   = { family = monoFont; style = "Bold"; };
        italic = { family = monoFont; style = "Italic"; };
        size = 10;
      };
      colors = {
        primary = {
          background = "0xeff1f5";
          foreground = "0x4c4f69";
          dim_foreground = "0x8c8fa1";
          bright_foreground = "0x4c4f69";
        };
        cursor = {
          text = "0xeff1f5";
          cursor = "0xdc8a78";
        };
        vi_mode_cursor = {
          text = "0xeff1f5";
          cursor = "0x7287fd";
        };
        search = {
          matches = {
            foreground = "0xeff1f5";
            background = "0x6c6f85";
          };
          focused_match = {
            foreground = "0xeff1f5";
            background = "0x40a02b";
          };
        };
        footer_bar = {
          foreground = "0xeff1f5";
          background = "0x6c6f85";
        };
        hints = {
          start = {
            foreground = "0xeff1f5";
            background = "0xdf8e1d";
          };
          end = {
            foreground = "0xeff1f5";
            background = "0x6c6f85";
          };
        };
        selection = {
          text = "0xeff1f5";
          background = "0xdc8a78";
        };
        normal = {
          black   = "0xbcc0cc";
          red     = "0xd20f39";
          green   = "0x40a02b";
          yellow  = "0xdf8e1d";
          blue    = "0x1e66f5";
          magenta = "0xea76cb";
          cyan    = "0x179299";
          white   = "0x5c5f77";
        };
        bright = {
          black   = "0xacb0be";
          red     = "0xd20f39";
          green   = "0x40a02b";
          yellow  = "0xdf8e1d";
          blue    = "0x1e66f5";
          magenta = "0xea76cb";
          cyan    = "0x179299";
          white   = "0x6c6f85";
        };
        indexed_colors = [
          { index = 16; color = "0xfe640b"; }
          { index = 17; color = "0xdc8a78"; }
        ];
      };
    };
  };

  home.sessionVariables = {
    CC = "gcc";
    CXX = "g++";
    RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";
    SCCACHE_DIR = "$HOME/.cache/sccache";
    CARGO_TARGET_DIR = "$HOME/.cargo-target";
    RUSTFLAGS = "-Clink-arg=-fuse-ld=${pkgs.mold}/bin/mold";
    QT_PLUGIN_PATH = "${pkgs.qt6Packages.qtbase}/lib/qt6/plugins";
    QML2_IMPORT_PATH = "${pkgs.qt6Packages.qtdeclarative}/lib/qt6/qml:${pkgs.qt6Packages.qtcharts}/lib/qt6/qml";
    QT_QPA_PLATFORM = "wayland,xcb";

    # Qt
    QT_PREFIX = "${pkgs.qt6Packages.qtbase}";
    Qt6_DIR = "${pkgs.qt6Packages.qtbase}/lib/cmake/Qt6";
    CMAKE_PREFIX_PATH = "${pkgs.qt6Packages.qtbase}";
    CMAKE_IGNORE_PREFIX_PATH = "/etc/profiles/per-user/yuki";

    # SDL3
    SDL3_PREFIX = "${pkgs.sdl3}";
    SDL3_DIR = "${pkgs.sdl3}/lib/cmake/SDL3";
  };

  xdg.configFile = {
    "fuzzel/fuzzel.ini".text = ''
      [main]
      font=${monoFont}:style=Regular:size=12
      prompt=
      icons=true

      [colors]
      background=eff1f5ff
      text=4c4f69ff
      match=1e66f5ff
      selection=dc8a78ff
      selection-text=eff1f5ff
      border=8c8fa1ff
    '';
    "kdeglobals".source = pkgs.replaceVars ../../../assets/kde/kdeglobals {
      inherit font monoFont;
    };
    "kglobalshortcutsrc".source = ../../../assets/kde/kglobalshortcutsrc;
    "ksplashrc".source = ../../../assets/kde/ksplashrc;
    "kwinrc".source = ../../../assets/kde/kwinrc;
    "plasma-org.kde.plasma.desktop-appletsrc".source = ../../../assets/kde/plasma-org.kde.plasma.desktop-appletsrc;
    "kded5rc".source = ../../../assets/kde/kded5rc;
    "powermanagementprofilesrc".source = ../../../assets/kde/powermanagementprofilesrc;
    "kwalletrc".source = ../../../assets/kde/kwalletrc;
  };

  programs.plasma = {
    enable = true;
    workspace.wallpaper = wallpaper;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    profiles.default = {
      isDefault = true;
      extraConfig = builtins.readFile ../../../assets/librefox/user.js;

    };
  };

}

