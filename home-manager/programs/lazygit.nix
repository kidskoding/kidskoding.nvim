{
  programs.lazygit = {
    enable = true;

    settings = {
      os.editPreset = "nvim-remote";
      gui.nerdFontsVersion = "3";
      update.method = "never";

      git.diffRenderers = [
        {
          name = "difftastic";
          type = "extDiff";
          command = "difft --color=always";
        }
        {
          name = "difftastic inline";
          type = "extDiff";
          command = "difft --color=always --display=inline";
        }
      ];
    };
  };
}
