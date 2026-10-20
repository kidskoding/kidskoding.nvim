{
  programs.steam.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  home-manager.users.anirudh.imports = [./home.nix];
}
