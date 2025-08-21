{ config, pkgs, ... }:
let
  wall = ../../assets/wallpapers/02.jpg;
in
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
    kdePackages.dolphin
    qbittorrent
    thunderbird
    fuzzel
    iosevka-bin
    ibm-plex
    waybar
    grim slurp wl-clipboard
    hyprpaper

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

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${builtins.toString wall}
    wallpaper = ,${builtins.toString wall}
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1, preferred, 0x0, 1"
        "HDMI-A-1, preferred, 1920x0, 1.0"
      ];
      env = [
        "XCURSOR_SIZE,24"
      ];

      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "fuzzel";

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "0x7287fd";
        "col.inactive_border" = "0xacb0be";
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = true;
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 7, myBezier"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad = { natural_scroll = true; };
      };

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, D, exec, $menu"

        "$mod, Q, killactive,"
        "$mod, M, exit,"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        ''
          , Print, exec, grim -g "$(slurp)" - | wl-copy
        ''
      ];

      exec-once = [
        "hyprpaper"
      ];
    };
  };

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
