{
  programs.lazygit = {
    enable = true;

    settings = {
      gui = {
        nerdFontsVersion = "3";
        border = "rounded";
        showRandomTip = false;
      };

      update.method = "never";

      git = {
        overrideGpg = true;
        parseEmoji = true;
        log.showGraph = "always";

        diffRenderers = [
          {
            name = "difftastic";
            type = "extDiff";
            command = "difft --color=always --context={{diffContext}}";
          }
          {
            name = "difftastic inline";
            type = "extDiff";
            command = "difft --color=always --display=inline --context={{diffContext}}";
          }
          {
            name = "default";
            type = "rawGit";
          }
        ];
      };
    };
  };
}
