{...}: {
  flake.homeModules.anirudh = {
    stylix.targets = {
      bat.enable = false;
      gnome.enable = false;
      kde.enable = false;
      qt.enable = false;
      rofi.enable = false;
    };
  };
}
