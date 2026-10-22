{...}: {
  flake.nixosModules.stylix = ./_/default.nix;
  flake.homeModules.anirudh = ./_/home.nix;
}
