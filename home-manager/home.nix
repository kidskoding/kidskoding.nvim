{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
    ./default.nix
  ];

  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TSDK = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";

    # use old way for initializing projects with uv!
    UV_NO_PROJECT = 1;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
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

    # languages
    dotnet-sdk_11
    dune_3
    elmPackages.elm
    go
    jdk21
    (julia.withPackages ["LanguageServer"])

    # lua
    lua
    luarocks
    luaPackages.fennel

    ocaml
    php
    phpPackages.composer
    ruby
    scala_3
    swift
    swiftpm
    typst
    typescript
    zig

    # lsps
    dockerfile-language-server
    elmPackages.elm-language-server
    fennel-ls
    fish-lsp
    gopls
    graphql-language-service-cli
    intelephense
    jdt-language-server
    kotlin-language-server
    lua-language-server
    marksman
    metals
    nixd
    ocamlPackages.ocaml-lsp
    omnisharp-roslyn
    ruby-lsp
    shellcheck
    sourcekit-lsp
    sqls
    taplo
    terraform-ls
    tinymist
    ty
    vscode-langservers-extracted
    yaml-language-server
    zls

    # formatters / linters
    alejandra
    fnlfmt
    ocamlformat
    prettier
    ruff
    stylelint
    stylua
    typstyle

    # core developer tools
    bear
    bun
    cmake
    gradle
    libtool
    nodejs
    uv
    xmake

    # niche c / c++ tooling
    clang-tools
    ninja
    pkg-config
    valgrind

    # additional developer tooling
    claude-agent-acp
    codex-acp
    devenv
    doxygen
    duckdb
    github-cli
    irust
    mdbook
    mdbook-mermaid
    pandoc

    # applications
    basalt
    discord
    doxygen_gui
    harlequin
    libreoffice
    myx
    neovim-unwrapped
    obsidian
    prismlauncher
    ruffle
    spotify
    teams-for-linux
    wineWow64Packages.stable
    winetricks
    zathura
    zoom-us

    # gaming deps
    bottles
    dolphin-emu
    heroic
    lutris

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
