{...}: {
  flake.nixosModules.shell = ./_/shell;
  flake.homeModules.anirudh = ./_/shell/home.nix;
}
