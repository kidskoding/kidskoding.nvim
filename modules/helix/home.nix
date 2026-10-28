{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    # backup editor: helix fork with vim keybindings (evil-helix), will run as `hx`
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;

      settings = {
        theme = "gruvbox_custom";

        editor = {
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

      # overrides on top of built-in gruvbox, matching the nvim lualine/gruvbox tweaks
      themes.gruvbox_custom = {
        inherits = "gruvbox";

        # brackets and delimiters in plain fg, not orange
        "punctuation" = "fg1";

        # brighter middle text; normal-mode badge in yellow like lualine
        "ui.statusline" = {
          fg = "fg2";
          bg = "bg2";
        };
        "ui.statusline.normal" = {
          fg = "bg0";
          bg = "yellow0";
          modifiers = ["bold"];
        };
      };
    };
  };
}
