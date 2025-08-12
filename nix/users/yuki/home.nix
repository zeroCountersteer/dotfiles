{ config, pkgs, ... }:
{
  # imports = [ ../../modules/arduino-libs.nix ];

  home.username = "yuki";
  home.homeDirectory = "/home/yuki";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  programs.nushell.enable = true;

  programs.nushell.extraConfig = ''
    $env.config = {
      show_banner: false
    }
  '';

#   programs.nushell.extraConfig = ''
#     alias java8  = "${pkgs.temurin-jre-bin-8}/bin/java"
#     alias java11 = "${pkgs.temurin-jre-bin-11}/bin/java"
#     alias java17 = "${pkgs.temurin-jre-bin-17}/bin/java"
#     alias java21 = "${pkgs.temurin-jre-bin-21}/bin/java"
#   '';

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.size = 10;
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

#   xdg.enable = true;
#
#   xdg.dataFile."plasma/look-and-feel/Moe".source = "/home/yuki/.local/share/plasma/look-and-feel/Moe";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.besot.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.besot.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.besot.haiku.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.besot.haiku.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.comm.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.comm.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.commsol.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.commsol.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.exair.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.exair.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.exblue.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.exblue.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.expose.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.expose.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.irixium.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.irixium.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.nimbus.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.nimbus.desktop";
#   xdg.dataFile."plasma/look-and-feel/org.magpie.sonumatic.desktop".source = "/home/yuki/.local/share/plasma/look-and-feel/org.magpie.sonumatic.desktop";
#
#   programs.plasma.workspace = {
#     lookAndFeel = "org.magpie.expose.desktop";
#   };

  home.sessionVariables = {
    CC = "clang";
    CXX = "clang++";
#     JAVA8_HOME  = "${pkgs.temurin-jre-bin-8}";
#     JAVA11_HOME = "${pkgs.temurin-jre-bin-11}";
#     JAVA17_HOME = "${pkgs.temurin-jre-bin-17}";
#     JAVA21_HOME = "${pkgs.temurin-jre-bin-21}";
  };

  home.packages = with pkgs; [
#   Desktop
    github-desktop
    kdePackages.kate
    kdePackages.kiten
    qbittorrent
    thunderbird

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
}
