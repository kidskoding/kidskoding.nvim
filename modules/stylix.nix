{...}: {
  flake.nixosModules.stylix = ./_/stylix;
  flake.homeModules.anirudh = ./_/stylix/home.nix;
}
