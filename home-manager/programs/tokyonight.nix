{inputs, ...}: let
  app = {
    enable = true;
    style = "moon";
  };
in {
  imports = [inputs.tokyonight.homeManagerModules.default];

  programs = {
    ghostty.tokyonight = app;
    fish.tokyonight = app;
  };

  stylix.targets = {
    ghostty.colors.enable = false;
    fish.colors.enable = false;
  };
}
