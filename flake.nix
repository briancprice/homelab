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
        ({config, ... }: { 
          config.networking.hostName = "nixos-dev"; 
          config.system.stateVersion = "24.11";
        })

        # NixOS settings
        ./settings/nixos.nix

        # System settings
        ./hardware/qemu-guest.nix
        ./bootloaders/efi-default.nix
        ./networks/wired.nix
        ./settings/localization.nix
        
        # Services
        ./services/openssh-secure.nix
        
        # Desktops/apps
        ./desktops/cinnamon.nix
        ./package-sets/system-minimal.nix

        # Users
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
