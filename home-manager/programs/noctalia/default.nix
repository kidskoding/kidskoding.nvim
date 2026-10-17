{
  config,
  inputs,
  pkgs,
  ...
}: let
  dir = "${config.home.homeDirectory}/nixos/home-manager/programs/noctalia";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  home.packages = [
    (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      patches =
        (old.patches or [])
        ++ [
          ./patches/clock-markup.patch
          ./patches/markup-colors.patch
          ./patches/volume-icon-state.patch
          ./patches/audio-osd-muted-colors.patch
          ./patches/brightness-osd-color.patch
          ./patches/control-center-power-button.patch
          ./patches/battery-icon-thresholds.patch
          ./patches/lockscreen-login-clock.patch
          ./patches/lockscreen-battery-status.patch
          ./patches/lockscreen-header-caps-lock.patch
          ./patches/media-player-seek-bar.patch
          ./patches/solid-panels.patch
        ];
    }))
  ];

  xdg.configFile = {
    "noctalia/config.toml".source = link "${dir}/config.toml";
    "noctalia/conf.d".source = link "${dir}/conf.d";
    "noctalia/palettes".source = link "${dir}/palettes";
  };
}
