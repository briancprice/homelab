# flake.nix NixOS machine hardware configurations for my home lab
{
  description = "NixOS machine hardware configurations";

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

    # These configuration modules contain only
    # what is needed from a hardware perspective
    # and can be aded to the host configurations
    # in the final flake 
    nixosModules.lenovo-config = { config, ... }: {
        config.networking.hostName = "lenovo";

        imports = [
          disko.nixosModules.disko
          ./lenovo/disko.nix
          ./common/boot-efi.nix
          ./qemu-guest/hardware-configuration.nix
        ];
    };

    # These NixOs system configurations can be
    # used to bootstrap a base config after
    # installing disko to setup requirements
    # prior to installing the final
    # host configurations from the main flakes
    nixosConfigurations = {
      bootstrap-lenovo = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";
        specialArgs = { inherit inputs; };
        modules = [
          self.nixosModules.lenovo-config
          ./common/onboard-configuration.nix
        ];
      };
    };
  };
}
