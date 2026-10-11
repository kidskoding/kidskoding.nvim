{
  config,
  lib,
  inputs,
  osConfig,
  ...
}: let
  inherit (osConfig.evergarden) variant accent;
  evergarden = osConfig.theme == "evergarden";
in {
  stylix.targets.noctalia.colors.enable = !evergarden;

  programs.noctalia = lib.mkIf evergarden {
    customPalettes.evergarden = lib.importJSON "${inputs.evergarden-noctalia}/themes/evergarden-${variant}-${accent}.json";

    settings.theme = {
      mode = config.stylix.polarity;
      source = "custom";
      custom_palette = "evergarden";
    };
  };
}
