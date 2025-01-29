{ config, namespace, ... }:
{ 
  imports = [
    ./client.nix
    ./server.nix
  ];
}