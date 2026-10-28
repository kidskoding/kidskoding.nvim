{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    # backup editor: helix fork with vim keybindings (evil-helix), run as `hx`
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;

      settings.editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}
