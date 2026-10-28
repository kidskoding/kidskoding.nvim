{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    # backup editor for when nvim breaks: helix fork with vim keybindings, run as `hx`.
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;

      settings = {
        theme = "gruvbox";

        editor = {
          line-number = "relative";
          cursorline = true;
        };
      };
    };
  };
}
