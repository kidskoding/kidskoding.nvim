{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.anirudh = {user, ...}: {
    home-manager.users.${user}.imports = [
      self.homeModules.anirudh
      inputs.sops-nix.homeManagerModules.sops
    ];
  };
}
