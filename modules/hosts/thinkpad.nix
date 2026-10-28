{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.thinkpad = {user, ...}: {
    imports = [
      ../../hosts/thinkpad/hardware-configuration.nix
      ../../hosts/thinkpad/disko.nix
    ];

    my = {
      gpu = ["amd"];
      display = {
        width = 1920;
        height = 1200;
        scale = 1.2;
      };
    };

    stylix.fonts.sizes.terminal = 16;

    system.stateVersion = "26.05";
    home-manager.users.${user}.home.stateVersion = "26.05";
  };

  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      host = "thinkpad";
      user = "kidskoding";
    };
    modules = [
      self.nixosModules.base
      self.nixosModules.anirudh
      self.nixosModules.shell
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.stylix
      self.nixosModules.thinkpad
    ];
  };
}
