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

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
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
