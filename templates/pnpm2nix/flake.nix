{
  description = "pnpm project built from pnpm-lock.yaml";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.callPackage ./default.nix {};

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nodejs
        pnpm_11
      ];

      shellHook = ''
        [ -d .git ] || git init -q

        if [ ! -f pnpm-lock.yaml ]; then
          pnpm install
          touch node_modules
        elif [ ! -d node_modules ] || [ pnpm-lock.yaml -nt node_modules ]; then
          pnpm install --frozen-lockfile
          touch node_modules
        fi
      '';
    };
  };
}
