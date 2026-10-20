{config, ...}: let
  dir = "${config.home.homeDirectory}/nixos/programs";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  imports = [
    ./agents.nix
    ./obs.nix
    ./tickrs.nix
  ];

  xdg.configFile."nvim".source = link "${dir}/nvim";
}
