{...}: {
  flake.nixosModules.shell = ../config/shell;
  flake.homeModules.anirudh = ../config/shell/home.nix;
}
