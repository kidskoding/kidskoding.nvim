{config, ...}: let
  dir = "${config.home.homeDirectory}/nixos/programs";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  imports = [
    ./agents.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./ghostty.nix
    ./git.nix
    ./lazygit.nix
    ./obs.nix
    ./ssh.nix
    ./starship.nix
    ./tickrs.nix
    ./zellij.nix
  ];

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.configFile."nvim".source = link "${dir}/nvim";
}
