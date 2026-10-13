{
  programs.lazygit = {
    enable = true;

    settings.git.pagers = [
      {externalDiffCommand = "difft --color=always";}
    ];
  };
}
