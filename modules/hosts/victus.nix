{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.victus = {user, ...}: {
    imports = [
      ../../hosts/victus/hardware-configuration.nix
      ../../hosts/victus/disko.nix
      self.nixosModules.gaming
    ];

    my = {
      gpu = ["intel" "nvidia"];
      display = {
        width = 1920;
        height = 1080;
        refresh = 144.0;
        vrr = true;
        textScale = 1.25;
      };
    };

    boot.kernelParams = ["pci=noaer"];

    hardware.nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    system.stateVersion = "26.05";

    home-manager.users.${user} = {
      imports = [self.homeModules.gaming];
      home.stateVersion = "26.05";
    };
  };

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
