{...}: {
  flake.nixosModules.niri = ./_/default.nix;
  flake.homeModules.anirudh = ./_/home.nix;
}
