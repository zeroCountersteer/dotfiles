{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/gpu/M6500.nix
  ];

  environment.systemPackages = with pkgs; [
    steam-run
    wineWowPackages.stable
    winetricks
    dxvk
    vkd3d
    vulkan-tools
    mangohud
    vulkan-tools
    vulkan-loader
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      nss nspr
      glib gtk3 pango cairo gdk-pixbuf atk at-spi2-atk at-spi2-core
      fontconfig freetype expat dbus
      zlib zstd curl openssl
      stdenv.cc.cc.lib
      xorg.libX11 xorg.libXext xorg.libXrandr xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXxf86vm xorg.libxcb
      xorg.libXcomposite xorg.libXdamage xorg.libXfixes xorg.libXrender
      libxkbcommon
      libGL libdrm libgbm vulkan-loader
      SDL2 alsa-lib pulseaudio
      cups
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "233ccaac2706b060"
    ];
  };

  networking.hostName = "yuki-machine";
  system.stateVersion = "25.05";
}
