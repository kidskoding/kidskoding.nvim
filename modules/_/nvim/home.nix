{
  inputs,
  config,
  pkgs,
  ...
}: let
  dir = "${config.home.homeDirectory}/nixos/modules/_/nvim";
  link = config.lib.file.mkOutOfStoreSymlink;
  neovim = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = [neovim];

  xdg.configFile."nvim".source = link "${dir}/config";
}
