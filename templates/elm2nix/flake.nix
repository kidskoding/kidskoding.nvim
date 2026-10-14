{
  description = "elm project built from elm.json";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.callPackage ./default.nix {};

    devShells.${system}.default = pkgs.mkShell {
      packages =
        [pkgs.elm2nix]
        ++ (with pkgs.elmPackages; [
          elm
          elm-format
          elm-json
          elm-language-server
          elm-review
          elm-test
        ]);

      shellHook = ''
        [ -d .git ] || git init -q
        [ -f elm.json ] || yes | elm init

        if [ ! -f elm-srcs.nix ] || [ elm.json -nt elm-srcs.nix ]; then
          elm2nix convert > elm-srcs.nix
          elm2nix snapshot
        fi
      '';
    };
  };
}
