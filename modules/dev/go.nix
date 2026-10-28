{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    # go install puts binaries here (myleet, etc.)
    home.sessionPath = ["$HOME/go/bin"];

    home.packages = with pkgs; [
      go
      gopls
    ];
  };
}
