{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
