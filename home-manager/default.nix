{config, ...}: let
  dir = "${config.home.homeDirectory}/nixos/programs";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  imports = [
    ./agents.nix
    ./git.nix
    ./lazygit.nix
    ./obs.nix
    ./ssh.nix
    ./tickrs.nix
  ];

  xdg.configFile."nvim".source = link "${dir}/nvim";
}
