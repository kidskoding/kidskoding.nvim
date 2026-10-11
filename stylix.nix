{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.evergarden) variant;
  p = inputs.evergarden.lib.palette.${variant};
  capitalize = s: lib.toUpper (builtins.substring 0 1 s) + builtins.substring 1 (-1) s;

  evergardenScheme = {
    scheme = "Evergarden ${capitalize variant}";
    author = "comfysage";
    base00 = p.base;
    base01 = p.surface0;
    base02 = p.surface1;
    base03 = p.overlay0;
    base04 = p.subtext0;
    base05 = p.text;
    base06 = p.cherry;
    base07 = p.snow;
    base08 = p.red;
    base09 = p.orange;
    base0A = p.yellow;
    base0B = p.green;
    base0C = p.aqua;
    base0D = p.blue;
    base0E = p.purple;
    base0F = p.pink;
  };

  tokyonightHelix = builtins.readFile "${inputs.tokyonight.inputs.tokyonight}/extras/helix/tokyonight_moon.toml";
  t = lib.mapAttrs (_: lib.removePrefix "#") (
    builtins.fromTOML (builtins.elemAt (builtins.split "\\[palette]" tokyonightHelix) 2)
  );

  tokyonightScheme = {
    scheme = "Tokyo Night Moon";
    author = "folke";
    base00 = t.bg;
    base01 = t.bg_highlight;
    base02 = t.bg_visual;
    base03 = t.comment;
    base04 = t.fg_dark;
    base05 = t.fg;
    base06 = t.fg;
    base07 = t.fg;
    base08 = t.red;
    base09 = t.orange;
    base0A = t.yellow;
    base0B = t.green;
    base0C = t.cyan;
    base0D = t.blue;
    base0E = t.magenta;
    base0F = t.red1;
  };
in {
  options.theme = lib.mkOption {
    type = lib.types.enum ["evergarden" "tokyo-night-moon"];
    default = "evergarden";
  };

  config = {
    theme = "tokyo-night-moon";

    evergarden = {
      variant = "fall";
      accent = "green";
    };

    stylix = {
      enable = true;

      base16Scheme =
        if config.theme == "evergarden"
        then evergardenScheme
        else tokyonightScheme;
      polarity = "dark";

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.terminess-ttf;
          name = "Terminess Nerd Font Mono";
        };

        sansSerif = config.stylix.fonts.monospace;
        serif = config.stylix.fonts.monospace;
        sizes.terminal = 16;
      };

      cursor = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 32;
      };

      opacity.terminal = 0.8;

      targets.console.enable = false;
      targets.grub.enable = false;
      targets.nixos-icons.enable = false;
      targets.plymouth.enable = false;
    };

    home-manager.users.anirudh.stylix.targets = {
      gnome.enable = false;
      kde.enable = false;
    };
  };
}
