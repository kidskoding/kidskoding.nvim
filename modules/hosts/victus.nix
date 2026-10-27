{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.victus = {user, ...}: {
    imports = [
      ../../hosts/victus/hardware-configuration.nix
      ../../hosts/victus/disko.nix
      ../../hosts/victus/nvidia.nix
      self.nixosModules.gaming
    ];

    system.stateVersion = "26.05";

    home-manager.users.${user}.imports = [
      self.homeModules.victus
      self.homeModules.gaming
    ];
  };

  flake.homeModules.victus = ../../hosts/victus/home.nix;

  flake.nixosConfigurations.victus = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      host = "victus";
      user = "anirudh";
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
