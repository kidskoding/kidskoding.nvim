{...}: {
  flake.nixosModules.stylix = {
    config,
    inputs,
    lib,
    pkgs,
    ...
  }: let
    nerdFont = {
      package = pkgs.nerd-fonts.fira-code;
      family = "FiraCode Nerd Font";
    };
  in {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
      override.base05 = "#ebdbb2";
      polarity = "dark";

      fonts = {
        monospace = lib.mkDefault {
          inherit (nerdFont) package;
          name = "${nerdFont.family} Mono";
        };

        sansSerif = lib.mkDefault {
          inherit (nerdFont) package;
          name = "${nerdFont.family} Propo";
        };

        serif = config.stylix.fonts.sansSerif;
        sizes.terminal = lib.mkDefault 16;
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
      targets.qt.enable = false;
    };
  };
}
