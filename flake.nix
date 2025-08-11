{
  description = "NixOS + Home Manager dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware }:
  let
    mkSystem = { system, hostname, username, extraModules ? [ ] }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nix/hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            networking.hostName = hostname;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./nix/users/${username}/home.nix;
          }
        ] ++ extraModules;
      };
  in {
    nixosConfigurations.yuki-machine = mkSystem {
      system = "x86_64-linux";
      hostname = "yuki-machine";
      username = "yuki";
      extraModules = [ ];
    };
  };
}
