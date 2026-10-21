{...}: {
  flake.nixosModules.stylix = ../config/stylix;
  flake.homeModules.anirudh = ../config/stylix/home.nix;
}
