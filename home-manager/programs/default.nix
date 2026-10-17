{inputs, ...}: {
  imports = [
    ./niri
    ./noctalia.nix
    ./nvim.nix

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
    ./zellij.nix
  ];

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
