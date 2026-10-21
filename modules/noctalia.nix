{...}: {
  flake.nixosModules.noctalia = ../config/noctalia;
  flake.homeModules.anirudh = ../config/noctalia/home.nix;
}
