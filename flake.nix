{
  description = "NixOS development machine configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
   };
  outputs = { self, nixpkgs, home-manager, ...}@inputs:
  let
  in {
    nixosConfigurations.nixos-dev = nixpkgs.lib.nixosSystem {
      system = "x86_64_linux";
      modules = [
        ./configuration.nix
        ./settings/localization.nix
        ./users
         home-manager.nixosModules.home-manager {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.brian = import ./home-manager/brian.nix;
          }
      ];
    };
  };
}
