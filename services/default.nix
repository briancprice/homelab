{ config, namespace, lib, ... }:
with lib; {
  imports = [
    ./openssh
    ./nixos-distributed-builds
  ];

  config.${namespace}.homelab.services = {
    openSsh.enable = mkDefault false;
    distributedBuildClient.enable = mkDefault false;
    distributedBuildServer.enable = mkDefault false;
    openssh.enable = mkDefault false;
  };
}