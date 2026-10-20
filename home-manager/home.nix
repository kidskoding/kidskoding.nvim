{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
    ./default.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
    };
  };

  home.packages = with pkgs; [
    # additional user system tools
    cliphist
    fd
    jq
    ripgrep
    tree
    tree-sitter
    websocat
    wl-clipboard

    # applications
    basalt
    discord
    doxygen_gui
    harlequin
    libreoffice
    myx
    neovim-unwrapped
    obsidian
    popsicle
    ruffle
    spotify
    teams-for-linux
    zathura
    zoom-us

    # other really cool stuff!!
    asciiquarium-transparent
    cava
    cowsay
    dua
    fortune
    ghostscript
    gum
    imagemagick
    mermaid-cli
    pipes
    presenterm
    tickrs
    timr-tui
    tldr
    wtf

    # user utilities
    rclone
    sshfs

    # fonts
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    symbola
    corefonts

    # cloud
    awscli2
  ];
}
