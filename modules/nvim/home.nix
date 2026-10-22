{...}: {
  flake.homeModules.anirudh = {
    inputs,
    config,
    pkgs,
    ...
  }: let
    dir = "${config.home.homeDirectory}/nixos/modules/nvim/config";
    link = config.lib.file.mkOutOfStoreSymlink;
    system = pkgs.stdenv.hostPlatform.system;
    neovim = inputs.neovim-nightly-overlay.packages.${system}.default;
  in {
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    home.packages = [neovim];

    xdg.configFile."nvim".source = link dir;
  };
}
