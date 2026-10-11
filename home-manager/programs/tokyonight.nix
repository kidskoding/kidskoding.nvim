{
  lib,
  inputs,
  osConfig,
  ...
}: let
  enabled = osConfig.theme == "tokyo-night-moon";
  app = {
    enable = enabled;
    style = "moon";
  };
in {
  imports = [inputs.tokyonight.homeManagerModules.default];

  programs = {
    ghostty.tokyonight = app;
    fish.tokyonight = app;
    bat.tokyonight = app;
  };

  stylix.targets = {
    ghostty.colors.enable = lib.mkIf enabled false;
    fish.colors.enable = lib.mkIf enabled false;
    bat.colors.enable = lib.mkIf enabled false;
  };
}
