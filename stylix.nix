{
  config,
  lib,
  pkgs,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
  capitalize = s: lib.toUpper (builtins.substring 0 1 s) + builtins.substring 1 (-1) s;
  toPaletteKey = role: "m" + lib.concatMapStrings capitalize (lib.splitString "_" role);
in {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
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

    programs.noctalia.customPalettes.stylix.dark = lib.mapAttrs' (role: color:
      lib.nameValuePair (toPaletteKey role) (lib.mkForce color))
    (import ./home-manager/programs/noctalia/palette.nix c);
  };
}
