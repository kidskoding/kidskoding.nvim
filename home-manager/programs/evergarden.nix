{
  lib,
  inputs,
  osConfig,
  ...
}: let
  enabled = osConfig.theme == "evergarden";
in {
  imports = [inputs.evergarden.homeManagerModules.default];

  evergarden = {
    inherit (osConfig.evergarden) variant accent;

    ghostty.enable = enabled;
    fish.enable = enabled;
  };

  home.sessionVariables = {
    EVERGARDEN_VARIANT = osConfig.evergarden.variant;
    EVERGARDEN_ACCENT = osConfig.evergarden.accent;
  };

  stylix.targets = {
    ghostty.colors.enable = lib.mkIf enabled false;
    fish.colors.enable = lib.mkIf enabled false;
  };
}
