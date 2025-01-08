{
  description = "NixOS development machine configuration";

  inputs = {

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # disko
    inputs.disko.url = "github:nix-community/disko/latest";
    inputs.disko.inputs.nixpkgs.follow = "nixpkgs"; 
  };

  outputs = { self, nixpkgs, disko, ... }@inputs:
  let
  in {
    nixosModules = rec {
      disko = {
        disko.devices = {
          disk.main = import ../common/disko-disk-1-ext4.nix;
        }
      }
    }

    nixosConfigurations
      bootstrap-lenovo = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";

        specialArgs = { inherit inputs; };
        modules = [

          ({config, ... }: { 
            config.networking.hostName = "lenovo";
          })

          self.nixosModules.disko
          ../qemu-guest/hardware-configuration.nix
          ../common/default.nix
      ];
    };
  };
}