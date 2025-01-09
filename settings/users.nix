# users.nix
# Default options for users
{ config, ... }:
{
  users.solitaryByDefault = true;
  users.mutableUsers = false;
  
}