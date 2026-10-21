{...}: {
  flake.nixosModules.niri = ../config/niri;
  flake.homeModules.anirudh = ../config/niri/home.nix;
}
