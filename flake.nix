{
  description = "NixOS + Home Manager with plasma-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    esp-dev.url = "github:mirrexagon/nixpkgs-esp-dev";
    esp-dev.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, esp-dev, plasma-manager, ... }:
  let
    wallpaper = ./assets/wallpapers/02.jpg;
    font = "IBM Plex Sans";
    monoFont = "IBM Plex Mono";
    mkSystem = { system, hostname, username, extraModules ? [ ] }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit wallpaper font monoFont; };
        modules = [
          ./nix/hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          { nixpkgs.overlays = [ esp-dev.overlays.default ]; }
          {
            networking.hostName = hostname;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit wallpaper font monoFont; };
            home-manager.users.${username} = {
              imports = [
                plasma-manager.homeManagerModules.plasma-manager
                ./nix/users/${username}/home.nix
              ];
            };
          }
        ] ++ extraModules;
      };
  in {
    nixosConfigurations.yuki-machine = mkSystem {
      system = "x86_64-linux";
      hostname = "yuki-machine";
      username = "yuki";
      extraModules = [
        ./nix/modules/common.nix
        ./nix/modules/gpu/M6500.nix
      ];
    };
  };
}
