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

    # Disko configuration for my lenovo laptop
    nixosModules.lenovo-disko = { config, ... }: {
      imports = [ inputs.disko.nixosModules.disko ];
      config.disko.devices = {
        disk.main = import ../common/disko-disk-1-ext4.nix;
      };
    };

    # Common configuration settings for my lenovo laptop
    nixosModules.lenovo-config = { config, ... }: {
        config.networking.hostName = "lenovo";

        imports = [
          self.nixosModules.lenovo-disko
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
