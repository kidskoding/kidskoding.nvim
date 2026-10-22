{...}: {
  flake.nixosModules.shell = ./_/default.nix;
  flake.homeModules.anirudh = ./_/home.nix;
}
