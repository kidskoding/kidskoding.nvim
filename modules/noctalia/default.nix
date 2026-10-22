{...}: {
  flake.nixosModules.noctalia = ./_/default.nix;
  flake.homeModules.anirudh = ./_/home.nix;
}
