{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    # use old way for initializing projects with uv!
    home.sessionVariables.UV_NO_PROJECT = 1;

    home.packages = with pkgs; [
      uv
      ruff
      ty
    ];
  };
}
