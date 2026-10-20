{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./disko.nix
    ./nvidia.nix

    ../../modules/gaming
  ];

  home-manager.users.anirudh.programs.niri.settings.outputs."eDP-1" = {
    mode = {
      width = 1920;
      height = 1080;
      refresh = 144.0;
    };
    position = {
      x = 0;
      y = 0;
    };
    scale = 1.0;
    variable-refresh-rate = "on-demand";
  };

  system.stateVersion = "26.05";
}
