{...}: {
  flake.nixosModules.niri = ./_/niri;
  flake.homeModules.anirudh = ./_/niri/home.nix;
}
