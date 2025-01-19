# flake.nix NixOS machine hardware configurations for my home lab
{
  description = "NixOS machine hardware configurations";

  inputs = {

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # disko
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # impermanence
    impermanence.url = "github:/nix-community/impermanence";
    # impermanence.inputs.nixpkgs.follows = "nixpkgs"; 
  };

  outputs = { self, nixpkgs, disko, impermanence, ... }@inputs:
  let
      stateVersion = "24.11"; # Did you read the comment?
  in {

    # These NixOs system configurations can be
    # used to bootstrap a base config after
    # installing disko to setup requirements
    # prior to installing the final
    # host configurations from the main flakes

    nixosModules = {
      qemuConfig = { config, ... }: {
        imports = [
          inputs.disko.nixosModules.disko
          ./qemu/machine-configuration.nix
        ];
      };

      lenovoConfig = { config, ... }: {
        imports = [
          inputs.disko.nixosModules.disko
          inputs.impermanence.nixosModules.impermanence
          ./lenovo/machine-configuration.nix
        ];
      };
    };

    nixosConfigurations = {

      # Base configuration for my lenovo laptop
      lenovo-bootstrap = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";
        modules = [
          ({ ... }: { system.stateVersion = stateVersion; })
          self.nixosModules.lenovoConfig
          ./common/onboard-configuration.nix
        ];
      };

      # Base configuration for a qemu vm
      qemu-guest-bootstrap = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";
        modules = [
          ({ ... }: { system.stateVersion = stateVersion; })
          self.nixosModules.qemuConfig
          ./common/onboard-configuration.nix
        ];
      };

    };

  };
}
