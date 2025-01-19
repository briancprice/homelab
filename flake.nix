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
  outputs = { self, nixpkgs, home-manager, homelab-machines, ... }:
  let 
    stateVersion = "24.11";

    # This namespace is used for all custom attributes
    namespace = "github__briancprice";

  in {

    # inherit (homelab-machines);
    
    # Onboarding Machine Configurations
    nixosConfigurations.lenovo = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";
        #specialArgs = { inherit homelab-machines; inherit namespace; };
        modules = [
          ({ config, ... }: { system.stateVersion = stateVersion;})
          homelab-machines.nixosModules.lenovoConfig
          ./machines/common/onboard-configuration.nix 
          ./settings
          ./services/nixos-distributed-builds/client.nix
          ./users/root/root.nix

           # Services
        ./services/openssh/openssh-permissive.nix
        ./services/nixos-distributed-builds/client.nix
        ];
      };

    # A development environment running in a vm
    nixosConfigurations.nixos-dev = nixpkgs.lib.nixosSystem {
      system = "x86_64_linux";

      modules = [

        # Inline module to streamline config
        ({config, ... }: with config; { 
          
          networking.hostName = "nixos-dev"; 
          system.stateVersion = stateVersion;
          
           # Boot settings...
           # Use the systemd-boot EFI boot loader.
           boot.loader.systemd-boot.enable = true;
           boot.loader.efi.canTouchEfiVariables = true;
        })

        # NixOS settings
        ./settings
        ./settings/flatpak.nix

        # System settings
        ./machines/dell-5810/hardware-configuration-with-filesystems.nix

        # Network Settings
        ./networks/wired.nix
        
        # Services
        ./services/openssh/openssh-secure.nix
        ./services/nixos-distributed-builds/server.nix
        
        # Desktops/apps
        ./desktops/cinnamon.nix
        ./package-sets/system-minimal.nix
        ./package-sets/system-admin.nix

        # Users
        ./users
         home-manager.nixosModules.home-manager {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.brian = import ./users/brian/brian-home-de.nix;
          }
      ];
    };
  };
}
