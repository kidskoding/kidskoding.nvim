{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.thinkpad = {
    pkgs,
    user,
    ...
  }: let
    # amd-pstate-epp: "powersave" governor already scales with load; EPP sets how eagerly it clocks up
    setEpp = pkgs.writeShellScript "set-epp" ''
      for f in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
        echo "$1" > "$f"
      done
    '';
  in {
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

    stylix.fonts.sizes.terminal = 14;

    systemd.tmpfiles.rules = [
      "w /sys/class/power_supply/BAT0/charge_control_end_threshold - - - - 100"
      "w /sys/class/power_supply/BAT0/charge_control_start_threshold - - - - 0"
    ];

    # full speed on the charger, kernel default on battery; "add" covers boot
    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", KERNEL=="AC", ACTION=="add|change", ATTR{online}=="1", RUN+="${setEpp} performance"
      SUBSYSTEM=="power_supply", KERNEL=="AC", ACTION=="add|change", ATTR{online}=="0", RUN+="${setEpp} balance_performance"
    '';

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?
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
