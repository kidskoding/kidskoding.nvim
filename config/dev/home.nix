{pkgs, ...}: {
  home.sessionVariables = {
    TSDK = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";

    # use old way for initializing projects with uv!
    UV_NO_PROJECT = 1;
  };

  # go install puts binaries here (myleet, etc.)
  home.sessionPath = ["$HOME/go/bin"];

  home.packages = with pkgs; [
    # languages
    dotnet-sdk_11
    dune_3
    elmPackages.elm
    go
    jdk21
    (julia.withPackages ["LanguageServer"])
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
    mdx-language-server
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
    irust
    mdbook
    mdbook-mermaid
    pandoc
  ];
}
