{
  description = "NixOS development machine configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # homelab-machines.url = "github:briancprice/homelab-machines";
    homelab-machines.url = "/home/brian/homelab-machines";
    homelab-machines.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = { self, nixpkgs, home-manager, homelab-machines, ... }:
  let 
    stateVersion = "24.11";

    # This namespace is used for all custom attributes
    namespace = "github__briancprice";
    system-x86_64-linux = "x86_64-linux";

  in {

    # inherit (homelab-machines);
    
    # Onboarding Machine Configurations
    /*
    nixosConfigurations.lenovo = nixpkgs.lib.nixosSystem {
        system = "x86_64_linux";
        specialArgs = { namespace = namespace; };
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
    */

    # A development environment running in a vm
    nixosConfigurations.nixos-dev = nixpkgs.lib.nixosSystem {
      system = system-x86_64-linux;
      specialArgs = { namespace = namespace; };
      modules = [
        # External modules
        homelab-machines.nixosModules.dell-5810Config
        home-manager.nixosModules.home-manager

        ({ config, ... }: {
          config.system.stateVersion = stateVersion;
          config.environment.systemPackages = [ 
            homelab-machines.packages.${system-x86_64-linux}.admin-scripts 
          ];
        })

        ./default.nix
        #./hosts/dell-5810.nix

        # Inline module to streamline config
        
        
      ];
    };
  };
}
