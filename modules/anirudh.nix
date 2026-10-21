{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.anirudh = {
    home-manager.users.anirudh.imports = [
      self.homeModules.anirudh
      inputs.sops-nix.homeManagerModules.sops
    ];
  };
}
