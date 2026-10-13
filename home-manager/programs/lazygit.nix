{
  programs.lazygit = {
    enable = true;

    settings.git.diffRenderers = [
      {
        name = "difftastic";
        type = "extDiff";
        command = "difft --color=always";
      }
    ];
  };
}
