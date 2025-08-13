{ config, pkgs, lib, ... }:

let
  wall = "${../../assets/wallpapers}/Omnipresence In Wired/scan04.jpg";

  breezeWithBg = pkgs.stdenv.mkDerivation {
    pname = "sddm-breeze-yuki";
    version = "1.1";
    dontUnpack = true;
    installPhase = ''
      set -e

      candidates=(
        "${pkgs.kdePackages.plasma-desktop}/share/sddm/themes/breeze"
        "${pkgs.kdePackages.plasma-workspace}/share/sddm/themes/breeze"
        "${pkgs.kdePackages.breeze}/share/sddm/themes/breeze"
      )

      src_theme=""
      for p in "''${candidates[@]}"; do
        if [ -d "$p" ]; then
          src_theme="$p"
          break
        fi
      done

      if [ -z "$src_theme" ]; then
        echo "SDDM Breeze theme not found in known locations."
        exit 1
      fi

      mkdir -p "$out/share/sddm/themes"
      cp -r "$src_theme" "$out/share/sddm/themes/breeze-yuki"

      cp ${wall} "$out/share/sddm/themes/breeze-yuki/background.jpg"

      if grep -q '^Background=' "$out/share/sddm/themes/breeze-yuki/theme.conf"; then
        sed -i "s|^Background=.*|Background=$out/share/sddm/themes/breeze-yuki/background.jpg|" \
          "$out/share/sddm/themes/breeze-yuki/theme.conf"
      else
        printf '\n[General]\nBackground=%s\n' "$out/share/sddm/themes/breeze-yuki/background.jpg" \
          >> "$out/share/sddm/themes/breeze-yuki/theme.conf"
      fi
    '';
  };
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };
  nix.optimise.automatic = true;

  time.timeZone = "Asia/Almaty";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_NUMERIC = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_COLLATE = "en_US.UTF-8";
  };
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "en_IE.UTF-8/UTF-8"
  ];

  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.displayManager.sddm = {
    enable = true;
    theme = "breeze-yuki";
    settings.Theme.Current = "breeze-yuki";
  };

  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.yuki = {
    isNormalUser = true;
    description = "yuki";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
  };
  users.defaultUserShell = pkgs.nushell;

  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  environment.systemPackages = with pkgs; [
    git
    kdePackages.sddm-kcm
    breezeWithBg
  ];

  home-manager.users.yuki = {
    programs.plasma.enable = true;
    programs.plasma.workspace.wallpaper = wall;
  };
}
