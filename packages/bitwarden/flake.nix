{
  description = "Bitwarden - Install the app package directly from vault.bitwarden.com";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }@inputs:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in {
    packages.x86_64-linux.default = self.packages.x86_64-linux.bitwarden;

    packages.x86_64-linux = {
      bitwarden = pkgs.callPackage ./bitwarden.nix {};
    };
  };
}
