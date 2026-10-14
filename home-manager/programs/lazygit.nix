{
  programs.lazygit = {
    enable = true;

    settings = {
      os.editPreset = "nvim-remote";
      gui.nerdFontsVersion = "3";
      update.method = "never";

      git.diffRenderers = [
        {
          name = "difftastic inline";
          type = "extDiff";
          command = "difft --color=always --display=inline";
        }
        {
          name = "difftastic";
          type = "extDiff";
          command = "difft --color=always --width=$LAZYGIT_COLUMNS";
        }
      ];
    };
  };
}
