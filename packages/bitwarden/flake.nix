{
  description = "Bitwarden - Install the bitwarden-cli package executable from vault.bitwarden.com";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }@inputs:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in {
    packages.x86_64-linux.default = self.packages.x86_64-linux.bitwarden-cli;

    packages.x86_64-linux = {
      # NixOS can't run dynamically linked executables so the desktop-version is broken
      bitwarden = pkgs.callPackage ./bitwarden.nix {};
      bitwarden-cli = pkgs.callPackage ./bitwarden-cli.nix {};
    };
  };
}
