# distributed-builds.nix
# This is the CLIENT configuration

# Configure an nfs share that will provide a single source of truth
# for machine builds accross the homelab network.
# Purpose:  Much faster for rapid iteration than github push or scp copy

# TODO: Create a way to dynamically switch the config source from
#   the nfs share vs github.  We want to avoid a homelab server updating with an unknown nfs state.

# TODO: Params (build machine and source machine)
# TODO: Add nfs-utils package here
# TODO: Don't hardcode urls
{ config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.homelab.services.distributedBuildClient;
in
with lib; {

  options.${namespace}.homelab.services.distributedBuildClient = {
    enable = mkEnableOption {
      default = false;
    };
  };

  config = mkIf cfg.enable {

    # nfs source share 
    fileSystems."/etc/nixos" = {
      # TODO: Read nfs build server from config
      device = "192.168.50.128:/etc/nixos";
      fsType = "nfs";
      options = [ "ro" "soft" "intr" "noauto" "x-systemd.automount" ];
      neededForBoot = false;
    };
    
    # Enable distributed builds
    nix.distributedBuilds = true;
    nix.settings.builders-use-substitutes = true;

    # Register the build machines
    nix.buildMachines = [
      {
        # TODO: Don't hardcode distributed-build servers
        hostName = "192.168.50.128";
        sshUser = "remotebuild";
        # TODO: Move remote-build key to sops
        sshKey = "/nix/persistent/secure/remotebuild";
        system = "${pkgs.stdenv.hostPlatform.system}";
        supportedFeatures = [ "nixos-test" "big-parallel" "kvm" ];
      }
    ];
  };
}