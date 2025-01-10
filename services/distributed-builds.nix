# distributed-builds.nix
# TODO: Don't hardcode distributed-build servers
{ pkgs, ... }:
{
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      hostName = "192.168.50.128";
      sshUser = "remotbuild";
      # TODO: Move remote-build key to sops
      # The key is in /etc/nixos because it's persisted for now.
      sshKey = "/etc/nixos/remotebuild";
      system = "${pkgs.stdenv.hostPlatform.system}";
      supportedFeatures = [ "nixos-test" "big-parallel" "kvm" ];
    }
  ];

}