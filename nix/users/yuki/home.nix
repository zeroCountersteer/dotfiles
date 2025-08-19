{ config, pkgs, ... }:
{
  # imports = [ ../../modules/arduino-libs.nix ];

  home.username = "yuki";
  home.homeDirectory = "/home/yuki";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
#   Desktop
    github-desktop
    kdePackages.kate
    kdePackages.kiten
    qbittorrent
    thunderbird
    waterfox

    fuzzel
    iosevka-bin
    ibm-plex

#   KDE Plasma
    kdePackages.sddm-kcm

#   EDA
    kicad
    kicadAddons.kikit
    freerouting
    freecad
    diylc

#   Games
    osu-lazer-bin
    steam
    retroarch-full
#     prismlauncher

#   CLI Tools
    ripgrep
    fd
    fastfetch

#   Java
#    temurin-jre-bin-8
#    temurin-jre-bin-11
#    temurin-jre-bin-17
#    temurin-jre-bin-21

#   Smart Home, must die
    miraclecast

#   Embedded toolchain
#    gcc-arm-embedded
    openocd
    stlink
    dfu-util
    arduino-cli
    stm32cubemx
    esptool

#   C/C++ toolchain
    gcc
#    clang
#    clang-tools
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

  home.sessionVariables.MOZ_ENABLE_WAYLAND = "1";

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = "waterfox.desktop";
    "x-scheme-handler/http" = "waterfox.desktop";
    "x-scheme-handler/https" = "waterfox.desktop";
    "x-scheme-handler/about" = "waterfox.desktop";
    "x-scheme-handler/unknown" = "waterfox.desktop";
  };

  home.file.".waterfox/profiles.ini".text = ''
    [General]
    StartWithLastProfile=1
    Version=2

    [Profile0]
    Name=default
    IsRelative=1
    Path=default
    Default=1
  '';

  home.file.".waterfox/default/user.js".text = ''
    user_pref("browser.bookmarks.addedImportButton", true);
    user_pref("browser.bookmarks.restore_default_bookmarks", false);
    user_pref("browser.bookmarks.showMobileBookmarks", true);
    user_pref("browser.contentblocking.category", "custom");
    user_pref("browser.download.viewableInternally.typeWasRegistered.avif", true);
    user_pref("browser.download.viewableInternally.typeWasRegistered.webp", true);
    user_pref("browser.engagement.sidebar-button.has-used", true);
    user_pref("browser.ml.chat.provider", "https://chatgpt.com");
    user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
    user_pref("browser.newtabpage.activity-stream.showSearch", false);
    user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
    user_pref("browser.newtabpage.enabled", false);
    user_pref("browser.policies.applied", true);
    user_pref("browser.preferences.experimental.hidden", true);
    user_pref("browser.startup.homepage", "chrome://browser/content/blanktab.html");
    user_pref("browser.startup.page", 3);
    user_pref("browser.toolbars.bookmarks.showOtherBookmarks", false);
    user_pref("browser.toolbars.bookmarks.visibility", "never");
    user_pref("browser.uiCustomization.horizontalTabsBackup", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"sponsorblocker_ajay_app-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"_57e8684d-5ae8-47d6-93c9-f870ef0e40a3_-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"_57e8684d-5ae8-47d6-93c9-f870ef0e40a3_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"unified-extensions-area\"],\"currentVersion\":23,\"newElementCount\":2}");
    user_pref("browser.uiCustomization.horizontalTabstrip", "[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"]");
    user_pref("browser.uiCustomization.navBarWhenVerticalTabs", "[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\",\"firefox-view-button\",\"alltabs-button\"]");
    user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"sponsorblocker_ajay_app-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"_57e8684d-5ae8-47d6-93c9-f870ef0e40a3_-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"unified-extensions-button\",\"firefox-view-button\",\"alltabs-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\",\"_57e8684d-5ae8-47d6-93c9-f870ef0e40a3_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"plasma-browser-integration_kde_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"unified-extensions-area\"],\"currentVersion\":23,\"newElementCount\":2}");
    user_pref("browser.urlbar.placeholderName", "DuckDuckGo");
    user_pref("browser.urlbar.placeholderName.private", "DuckDuckGo");
    user_pref("browser.urlbar.shortcuts.actions", false);
    user_pref("browser.urlbar.shortcuts.bookmarks", false);
    user_pref("browser.urlbar.shortcuts.history", false);
    user_pref("browser.urlbar.shortcuts.tabs", false);
    user_pref("browser.urlbar.suggest.bookmark", false);
    user_pref("browser.urlbar.suggest.engines", false);
    user_pref("browser.urlbar.suggest.history", false);
    user_pref("browser.urlbar.suggest.openpage", false);
    user_pref("dom.forms.autocomplete.formautofill", true);
    user_pref("dom.security.https_only_mode", true);
    user_pref("dom.security.https_only_mode_pbm", true);
    user_pref("extensions.activeThemeID", "default-theme@mozilla.org");
    user_pref("media.eme.enabled", true);
    user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
    user_pref("network.dns.disablePrefetch", true);
    user_pref("network.http.speculative-parallel-limit", 0);
    user_pref("network.predictor.enabled", false);
    user_pref("network.prefetch-next", false);
    user_pref("permissions.default.camera", 2);
    user_pref("permissions.default.geo", 2);
    user_pref("permissions.default.microphone", 2);
    user_pref("privacy.clearOnShutdown_v2.formdata", true);
    user_pref("privacy.fingerprintingProtection", true);
    user_pref("privacy.trackingprotection.enabled", true);
    user_pref("sidebar.main.tools", "aichat,syncedtabs,history,bookmarks");
    user_pref("sidebar.revamp", true);
    user_pref("sidebar.verticalTabs", true);
  '';

  home.sessionVariables = {
    CC = "clang";
    CXX = "clang++";
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


  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, D, exec, fuzzel"
      ];
    };
  };


}
