{config, ...}: let
  dir = "${config.home.homeDirectory}/nixos/programs";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  imports = [
    ./niri

    ./agents.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./ghostty.nix
    ./git.nix
    ./lazygit.nix
    ./mangohud.nix
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

  xdg.configFile = {
    "nvim".source = link "${dir}/nvim";
    "noctalia/config.toml".source = link "${dir}/noctalia/config.toml";
    "noctalia/conf.d".source = link "${dir}/noctalia/conf.d";
    "noctalia/palettes".source = link "${dir}/noctalia/palettes";
  };
}
