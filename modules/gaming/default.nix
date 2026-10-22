{...}: {
  flake.nixosModules.gaming = ./_/default.nix;
  flake.homeModules.gaming = ./_/home.nix;
}
