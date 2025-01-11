# root.nix
# TODO: Remove need fo ssh access to root, now it's needed for at least remote builds
{ ... }:
{
    users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQM3PinzEcWHWb7JZ+5iJMttHhlbIizZ4T9bcXvCD3f" ];
    users.users.root.initialHashedPassword = "$y$j9T$ey8R7Bclqq3pWW477qgU//$xtVBLgFR5KsmRdM4pLfITdRnp2TdBDZ6I5T7Z4fnuE.";
}