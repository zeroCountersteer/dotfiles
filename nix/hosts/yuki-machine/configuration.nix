{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/gpu/M6500.nix
  ];

  environment.systemPackages = with pkgs; [
    steam-run
  ];

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

  networking.hostName = "yuki-machine";
  system.stateVersion = "25.05";
}
