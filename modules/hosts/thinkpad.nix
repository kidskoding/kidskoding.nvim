{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.thinkpad = {user, ...}: {
    imports = [
      ../../hosts/thinkpad/hardware-configuration.nix
    ];

    system.stateVersion = "26.05";

    home-manager.users.${user}.imports = [
      self.homeModules.thinkpad
    ];
  };

  flake.homeModules.thinkpad = ../../hosts/thinkpad/home.nix;

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
