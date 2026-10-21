{...}: {
  flake.nixosModules.gaming = ./_/gaming;
  flake.homeModules.gaming = ./_/gaming/home.nix;
}
