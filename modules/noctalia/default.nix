{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.noctalia-greeter.nixosModules.default];

  # greeter runs as the greeter user before login and cannot read ~/,
  # so its toml and assets go through the store and /etc (needs a rebuild)
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = ./greeter/greeter.toml;
  };

  environment.etc."noctalia-greeter/wallpaper.jpg".source = ./wallpapers/starfire-bg.jpg;

  environment.systemPackages = [
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
          ./patches/network-wifi-off-color.patch
          ./patches/bluetooth-off-color.patch
        ];
    }))
    pkgs.adwaita-icon-theme
  ];

  home-manager.users.anirudh.imports = [./home.nix];

  systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/anirudh"."f+".argument = "[User]\nIcon=${./avatars/starfire.jpeg}\n";
}
