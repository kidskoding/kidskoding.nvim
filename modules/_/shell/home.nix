{pkgs, ...}: {
  imports = [
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./ghostty.nix
    ./starship.nix
    ./zellij.nix
  ];

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    # additional user system tools
    cliphist
    fd
    jq
    ripgrep
    tree
    tree-sitter
    websocat
    wl-clipboard
  ];
}
