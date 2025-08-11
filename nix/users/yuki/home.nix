{ config, pkgs, ... }:
{
  imports = [ ./modules/arduino-libs.nix ];

  home.username = "yuki";
  home.homeDirectory = "/home/yuki";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  programs.nushell.enable = true;

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
        "browser.startup.homepage" = "https://nixos.org";
        "privacy.donottrackheader.enabled" = true;
      };
    };
  };

  programs.thunderbird.enable = true;

  home.sessionVariables = {
    CC = "clang";
    CXX = "clang++";
  };

  home.packages = with pkgs; [
#   Desktop
    github-desktop
    kdePackages.kate
    kdePackages.kiten
    qbittorrent

#   EDA
    kicad
    kicadAddons.kikit
    kicadAddons.kikit-library
    freerouting
    freecad
    diylc

#   Games
    osu-lazer-bin
    steam
    retroarch-full
    prismlauncher

#   CLI Tools
    ripgrep
    fd

#   Java
    jdk17
    jre8

#   Embedded toolchain
    arm-none-eabi-gcc
    arm-none-eabi-binutils
    arm-none-eabi-gdb
    openocd
    stlink
    dfu-util
    arduino-cli
    stm32cubemx
    esptool
    xtensa-esp32-elf
    xtensa-esp32s2-elf
    xtensa-esp32s3-elf
    riscv32-esp-elf

#   C/C++ toolchain
    gcc
    clang
    clang-tools
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
