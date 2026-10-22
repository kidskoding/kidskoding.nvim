{config, ...}: let
  dir = "${config.home.homeDirectory}/nixos/modules/noctalia/_";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile = {
    "noctalia/config.toml".source = link "${dir}/config.toml";
    "noctalia/conf.d".source = link "${dir}/conf.d";
    "noctalia/palettes".source = link "${dir}/palettes";
  };
}
