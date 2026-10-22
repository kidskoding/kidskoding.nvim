{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.victus = {
    imports = [
      ./_/hardware-configuration.nix
      ./_/disko.nix
      ./_/nvidia.nix
      self.nixosModules.gaming
    ];

    system.stateVersion = "26.05";

    home-manager.users.anirudh.imports = [
      self.homeModules.victus
      self.homeModules.gaming
    ];
  };

  flake.homeModules.victus = ./_/home.nix;

  flake.nixosConfigurations.victus = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      host = "victus";
    };
    modules = [
      self.nixosModules.base
      self.nixosModules.anirudh
      self.nixosModules.shell
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.stylix
      self.nixosModules.victus
    ];
  };
}
