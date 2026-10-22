{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = [pkgs.github-cli];
  };
}
