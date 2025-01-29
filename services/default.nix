{ config, namespace, lib, ... }:
with lib; {
  imports = [
    ./openssh
    #./nixos-distributed-builds
    ./virtualisation
    ( { config, lib, namespace, ... }: with lib; {
      config.${namespace}.homelab.services = {
        openssh.enable = mkDefault false;
        virtualisation.enable = mkDefault false;
        #distributedBuildClient.enable = mkDefault false;
        #distributedBuildServer.enable = mkDefault false;
      };
    })
  ];
}