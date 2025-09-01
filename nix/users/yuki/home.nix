{ config, pkgs, ... }:
{
  # imports = [ ../../modules/arduino-libs.nix ];

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
  qt6.full
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
        normal = { family = "IBM Plex Mono"; style = "Regular"; };
        bold   = { family = "IBM Plex Mono"; style = "Bold"; };
        italic = { family = "IBM Plex Mono"; style = "Italic"; };
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

  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    [main]
    font=IBM Plex Mono:style=Regular:size=12
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

  programs.firefox = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      settings = {
        "browser.bookmarks.addedImportButton" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.contentblocking.category" = "custom";
        "browser.download.viewableInternally.typeWasRegistered.avif" = true;
        "browser.download.viewableInternally.typeWasRegistered.webp" = true;
        "browser.engagement.sidebar-button.has-used" = true;
        "browser.ml.chat.provider" = "https://chatgpt.com";
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.enabled" = false;
        "browser.policies.applied" = true;
        "browser.preferences.experimental.hidden" = true;
        "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
        "browser.startup.page" = 3;
        "browser.toolbars.bookmarks.showOtherBookmarks" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.uiCustomization.horizontalTabsBackup" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"sponsorblocker_ajay_app-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"_57e8684d-5ae8-47d6-93c9-f870ef0e40a3_-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"_57e8684d-5ae8-47d6-93c9-f870ef0e40a3_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"unified-extensions-area\"],\"currentVersion\":23,\"newElementCount\":2}";
        "browser.uiCustomization.horizontalTabstrip" = "[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"]";
        "browser.uiCustomization.navBarWhenVerticalTabs" = "[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\",\"firefox-view-button\",\"alltabs-button\"]";
        "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"sponsorblocker_ajay_app-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"_57e8684d-5ae8-47d6-93c9-f870ef0e40a3_-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\",\"firefox-view-button\",\"alltabs-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"_57e8684d-5ae8-47d6-93c9-f870ef0e40a3_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"unified-extensions-area\"],\"currentVersion\":23,\"newElementCount\":2}";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.placeholderName.private" = "DuckDuckGo";
        "browser.urlbar.shortcuts.actions" = false;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "dom.forms.autocomplete.formautofill" = true;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_pbm" = true;
        "extensions.activeThemeID" = "default-theme@mozilla.org";
        "media.eme.enabled" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "network.dns.disablePrefetch" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "permissions.default.camera" = 2;
        "permissions.default.geo" = 2;
        "permissions.default.microphone" = 2;
        "privacy.clearOnShutdown_v2.formdata" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.trackingprotection.enabled" = true;
        "sidebar.main.tools" = "aichat,syncedtabs,history,bookmarks";
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
      };
    };
  };
}

