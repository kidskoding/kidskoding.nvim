{
  imports = [
    ./agents
    ./apps
    ./git
    ./niri
    ./noctalia
    ./nvim
    ./shell
    ./stylix
  ];

  home-manager.users.anirudh.imports = [./home.nix];
}
