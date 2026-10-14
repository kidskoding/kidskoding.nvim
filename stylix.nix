{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  helix = builtins.readFile "${inputs.tokyonight.inputs.tokyonight}/extras/helix/tokyonight_moon.toml";
  t = lib.mapAttrs (_: lib.removePrefix "#") (
    builtins.fromTOML (builtins.elemAt (builtins.split "\\[palette]" helix) 2)
  );
in {
  stylix = {
    enable = true;

    base16Scheme = {
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

    opacity.terminal = 0.75;

    targets.console.enable = false;
    targets.grub.enable = false;
    targets.nixos-icons.enable = false;
    targets.plymouth.enable = false;
    targets.qt.enable = false;
  };

  home-manager.users.anirudh = {
    stylix.targets = {
      bat.enable = false;
      gnome.enable = false;
      kde.enable = false;
      qt.enable = false;
    };

    programs.noctalia.customPalettes.stylix.dark = lib.mapAttrs (_: lib.mkForce) {
      mSurface = "#${t.bg_statusline}";
      mOnSurface = "#${t.fg}";
      mSurfaceVariant = "#${t.fg_gutter}";
      mOnSurfaceVariant = "#${t.fg_sidebar}";
      mPrimary = "#${t.blue}";
      mOnPrimary = "#${t.black}";
      mSecondary = "#${t.magenta}";
      mOnSecondary = "#${t.black}";
      mTertiary = "#${t.green}";
      mOnTertiary = "#${t.black}";
      mError = "#${t.red}";
      mOnError = "#${t.black}";
      mHover = "#${t.bg_visual}";
      mOnHover = "#${t.fg}";
      mOutline = "#${t.fg_gutter}";
      mShadow = "#${t.black}";
    };
  };
}
