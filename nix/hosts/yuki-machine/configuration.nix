{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/gpu/m6500.nix
  ];

  networking.hostName = "yuki-machine";
  system.stateVersion = "25.05";
}
