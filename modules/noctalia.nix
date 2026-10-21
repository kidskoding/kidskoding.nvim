{...}: {
  flake.nixosModules.noctalia = ./_/noctalia;
  flake.homeModules.anirudh = ./_/noctalia/home.nix;
}
