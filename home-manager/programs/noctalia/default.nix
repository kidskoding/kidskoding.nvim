{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default

    ./bar.nix
    ./launcher.nix
    ./lock.nix
    ./notifications.nix
  ];

  programs.noctalia = {
    enable = true;

    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
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
        ];
    });

    settings = {
      accessibility.ui_scale = 1.2;
      osd.kinds.media = false;
      plugins.enabled = ["noctalia/timer"];

      control_center.sidebar_section = "none";

      shell = {
        time_format = "{:%-I:%M %p}";
        avatar_path = "${./avatars/starfire.jpeg}";
        panel = {
          control_center_placement = "floating";
          control_center_position = "top_left";
          open_near_click_control_center = false;
          session_placement = "floating";
          session_position = "center";
          open_near_click_session = false;
          open_near_click_wallpaper = true;
        };
      };

      location.auto_locate = true;

      weather = {
        enabled = true;
        unit = "imperial";
      };

      battery.warning_threshold = 30;

      dock.enabled = false;
    };
  };
}
