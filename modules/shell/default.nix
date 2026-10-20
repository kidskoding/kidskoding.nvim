{pkgs, ...}: {
  programs.fish.enable = true;
  users.users.anirudh.shell = pkgs.fish;

  home-manager.users.anirudh.imports = [./home.nix];
}
