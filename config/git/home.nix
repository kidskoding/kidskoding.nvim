{pkgs, ...}: {
  imports = [
    ./git.nix
    ./lazygit.nix
    ./ssh.nix
  ];

  home.packages = [pkgs.github-cli];
}
