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

    zellij = {
      themes.tokyonight_moon = "${inputs.tokyonight.inputs.tokyonight}/extras/zellij/tokyonight_moon.kdl";
      settings.theme = "tokyonight_moon";
    };
  };

  stylix.targets = {
    ghostty.colors.enable = false;
    fish.colors.enable = false;
    zellij.enable = false;
  };
}
