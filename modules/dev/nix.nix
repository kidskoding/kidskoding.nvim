{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      nixd
      alejandra
      devenv
    ];
  };
}
