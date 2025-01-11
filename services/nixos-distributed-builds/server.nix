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

  # Trust the remote user
  nix.settings.trusted-users = [ "remotebuild" ];

  # Share the NixOS configuration file so that all machines in the homelab can reference it
  services.nfs.server = {
    enable = true;
    exports = [
      { 
        path = "/users/brian/homelab"; 
        options = [ "ro" "async" "no_subtree_check" ];
        clients = [ "192.168.10.0/24" ];
      }
    ];
  };
}
