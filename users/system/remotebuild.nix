{
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

     openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILyBSbCWDf7HzOCRBvgWDr4thKbVA088Yp/nibZTx50u" ];
  };

  users.groups.remotebuild = {};
  nix.settings.trusted-users = [ "remotebuild" ];
}