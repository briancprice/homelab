# server.nix
# Enables distributed builds on this server
{ ... }:
{
  # Create the remotebuild group
  users.groups.remotebuild = {};

  # Create the remotebuild user
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    # TODO: sops - Store the remotebuild sshkey in sops
     openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILyBSbCWDf7HzOCRBvgWDr4thKbVA088Yp/nibZTx50u" ];
  };

  # Create a bind-mount for the nixos configuration
  fileSystems."/etc/nixos" = {
    # TODO: Read nfs build server from config
    device = "/home/users/brian/homelab";
    options = [ "ro" "bind" ];
    neededForBoot = false;
  };

  # Trust the remote user
  nix.settings.trusted-users = [ "remotebuild" ];

  # Share the NixOS configuration file so that all machines in the homelab can reference it
  services.nfs.server = {
    enable = true;
    exports = 
    ''
    /etc/nixos 192.168.50.0/24(ro,async,no_subtree_check)
    '';
  };
  # Open the ports in the firewall
  networking.firewall.allowedTCPPorts = [ 2049 1111 4000 4001 20048 ];
  networking.firewall.allowedUDPPorts = [ 2049 1111 4000 4001 20048 ];
}
