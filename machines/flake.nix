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

    # These NixOs system configurations can be
    # used to bootstrap a base config after
    # installing disko to setup requirements
    # prior to installing the final
    # host configurations from the main flakes

    nixosConfigurations = {
      lenovo-bootstrap = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./lenovo/machine-configuration.nix
          ./common/onboard-configuration.nix
        ];
      };
    };
  };
}
