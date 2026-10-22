{pkgs, ...}: {
  programs.fish.enable = true;
  users.users.anirudh.shell = pkgs.fish;
}
