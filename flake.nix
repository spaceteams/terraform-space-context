{
  description = "Spaceteams context module for terraform";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
  inputs.master.url = "github:NixOS/nixpkgs/master";

  inputs.utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, master, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        unstable = import master { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          name = "terraform-space-context";
          packages = with unstable; [ terraform go gopls gnumake terraform-ls ];
        };
      });
}
