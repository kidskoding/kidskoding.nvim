{...}: {
  flake.nixosModules.gaming = ../config/gaming;
  flake.homeModules.gaming = ../config/gaming/home.nix;
}
