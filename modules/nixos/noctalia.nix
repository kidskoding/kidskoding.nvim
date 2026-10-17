{
  inputs,
  pkgs,
  ...
}: {
  # greeter runs as the greeter user before login and cannot read ~/,
  # so its toml and assets go through the store and /etc (needs a rebuild)
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = ../../programs/noctalia/greeter/greeter.toml;
  };

  environment.etc."noctalia-greeter/wallpaper.jpg".source = ../../home-manager/wallpaper/images/starfire-bg.jpg;

  environment.systemPackages = [
    (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      patches =
        (old.patches or [])
        ++ [
          ../../programs/noctalia/patches/clock-markup.patch
          ../../programs/noctalia/patches/markup-colors.patch
          ../../programs/noctalia/patches/volume-icon-state.patch
          ../../programs/noctalia/patches/audio-osd-muted-colors.patch
          ../../programs/noctalia/patches/brightness-osd-color.patch
          ../../programs/noctalia/patches/control-center-power-button.patch
          ../../programs/noctalia/patches/battery-icon-thresholds.patch
          ../../programs/noctalia/patches/lockscreen-login-clock.patch
          ../../programs/noctalia/patches/lockscreen-battery-status.patch
          ../../programs/noctalia/patches/lockscreen-header-caps-lock.patch
          ../../programs/noctalia/patches/media-player-seek-bar.patch
          ../../programs/noctalia/patches/solid-panels.patch
        ];
    }))
    pkgs.adwaita-icon-theme
  ];

  systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/anirudh"."f+".argument = "[User]\nIcon=${../../programs/noctalia/avatars/starfire.jpeg}\n";
}
