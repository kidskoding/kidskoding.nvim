{pkgs, ...}: {
  # greeter runs as the greeter user before login and cannot read ~/,
  # so its toml and assets go through the store and /etc (needs a rebuild)
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = ./greeter.toml;
  };

  environment.etc."noctalia-greeter/wallpaper.jpg".source = ../../wallpaper/images/starfire-bg.jpg;

  environment.systemPackages = [pkgs.adwaita-icon-theme];

  systemd.tmpfiles.settings."10-accountsservice-avatar"."/var/lib/AccountsService/users/anirudh"."f+".argument = "[User]\nIcon=${./avatars/starfire.jpeg}\n";

  fonts.packages = [pkgs.nerd-fonts.terminess-ttf];
}
