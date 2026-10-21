{
  config,
  pkgs,
  ...
}: let
  dir = "${config.home.homeDirectory}/nixos/modules/nvim";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = [pkgs.neovim-unwrapped];

  xdg.configFile."nvim".source = link "${dir}/config";
}
