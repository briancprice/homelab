{
  description = "NixOS development machine configuration";

  inputs = {

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # disko
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs"; 
  };

  outputs = { self, nixpkgs, disko, ... }@inputs:
  let
  in {

    # Common configuration settings for my lenovo laptop
    nixosModules.lenovo-config = { config, ... }: {
        config.networking.hostName = "lenovo";

        imports = [
          disko.nixosModules.disko
          ./disko.nix
          ../common/boot-efi.nix
          ../qemu-guest/hardware-configuration.nix
        ];
    };

    nixosConfigurations = {
      bootstrap-lenovo = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";
        specialArgs = { inherit inputs; };
        modules = [
          self.nixosModules.lenovo-config
          ../common/default.nix
        ];
      };
    };
  };
}
