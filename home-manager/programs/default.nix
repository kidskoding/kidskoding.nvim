{
  config,
  inputs,
  ...
}: {
  imports = [
    ./niri
    ./noctalia

    ./agents.nix
    ./fastfetch.nix
    ./fish.nix
    ./ghostty.nix
    ./git.nix
    ./lazygit.nix
    ./mangohud.nix
    ./obs.nix
    ./ssh.nix
    ./starship.nix
    ./tickrs.nix
    ./tokyonight.nix
    ./zellij.nix
  ];

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # neovim config managed separately and is in its own repo (subtree)
  # linked live so edits do not need any rebuild
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos/home-manager/programs/nvim";
}
