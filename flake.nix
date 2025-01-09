{
  description = "NixOS development machine configuration";

  inputs = {

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager    
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Machine configurations
    homelab-machines.url = ./machines
    homelab-machines.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = { self, nixpkgs, home-manager, homelab-machines ... }@inputs:
  let
  in {


    # Onboarding Machine Configurations
    nixosConfigurations.lenovo-bootstrap = homelab-machines.lenovo-bootstrap;

    nixosConfigurations.nixos-dev = nixpkgs.lib.nixosSystem {
      system = "x86_64_linux";

      specialArgs = { inherit inputs; };
      modules = [

        # Inline module to streamline config
        ({config, pkgs, inputs, ... }: { 
          config.networking.hostName = "nixos-dev"; 
          config.system.stateVersion = "24.11";
        })

        # NixOS settings
        ./settings/nixos.nix

        # System settings
        ./hardware/qemu-guest.nix
        ./machines/common/boot-efi.nix

        # Network Settings
        ./networks/wired.nix
        ./networks/network-host-id.nix

        # Misc Settings
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
