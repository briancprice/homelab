{
  description = "NixOS development machine configuration";

  inputs = {

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager    
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Machine configurations
    homelab-machines.url = "./machines";
    homelab-machines.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = { self, nixpkgs, home-manager, homelab-machines, ... }@inputs:
  let
    wrapped_homelab_machines = homelab-machines;
  in {

    inherit (inputs.homelab-machines);

    # Onboarding Machine Configurations

    nixosConfigurations.lenovo = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";
        specialArgs = homelab-machines;
        modules = [
          inputs.homelab-machines.nixosModules.lenovoConfig
          ./machines/common/onboard-configuration.nix 
          ./settings/nixos.nix
          ./users/system/remotebuild.nix
        ];
      };

    # A development environment running in a vm
    nixosConfigurations.nixos-dev = nixpkgs.lib.nixosSystem {
      system = "x86_64_linux";

      specialArgs = { inherit inputs; };
      modules = [

        # Inline module to streamline config
        ({config, pkgs, inputs, ... }: with config; { 
          
          networking.hostName = "nixos-dev"; 
          system.stateVersion = "24.11";
          
           # Boot settings...
           # Use the systemd-boot EFI boot loader.
           boot.loader.systemd-boot.enable = true;
           boot.loader.efi.canTouchEfiVariables = true;
        })

        # NixOS settings
        ./settings/nixos.nix

        # System settings
        ./hardware/qemu-guest.nix

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
