{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    # backup editor: helix fork with vim keybindings (evil-helix), will run as `hx`
    programs.helix = {
      enable = true;

      # evil mode overwrites statusline.mode with NOR/INS/VIS; drop that so the names below apply
      package = pkgs.evil-helix.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            ./patches/statusline-mode-names.patch
          ];
      });

      settings = {
        theme = "gruvbox";

        editor = {
          line-number = "relative";
          cursorline = true;
          color-modes = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          statusline = {
            left = ["mode" "version-control" "file-name" "file-modification-indicator"];
            right = ["spinner" "diagnostics" "file-type" "selections" "position"];
            separator = "│";
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "VISUAL";
            };
          };
        };
      };
    };
  };
}
