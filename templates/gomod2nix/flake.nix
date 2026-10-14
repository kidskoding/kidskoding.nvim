{
  description = "go project built from go.sum";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    gomod2nix = {
      url = "github:nix-community/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [inputs.gomod2nix.overlays.default];
    };
  in {
    packages.${system}.default = pkgs.callPackage ./default.nix {};

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        go
        gomod2nix

        air
        delve
        golangci-lint
        gomodifytags
        gopls
        gore
        gotests
        gotools
      ];

      shellHook = ''
        [ -d .git ] || git init -q
        [ -f go.mod ] || go mod init "$(basename "$PWD")"

        if [ ! -f gomod2nix.toml ] || [ go.mod -nt gomod2nix.toml ] || [ go.sum -nt gomod2nix.toml ]; then
          gomod2nix generate
        fi
      '';
    };
  };
}
