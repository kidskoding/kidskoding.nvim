{...}: {
  flake.homeModules.anirudh = {
    inputs,
    config,
    pkgs,
    ...
  }: let
    dir = "${config.home.homeDirectory}/nixos/modules/nvim/_";
    link = config.lib.file.mkOutOfStoreSymlink;
    neovim = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in {
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    home.packages = [neovim];

    xdg.configFile."nvim".source = link "${dir}/config";
  };
}
