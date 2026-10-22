{...}: {
  flake.homeModules.anirudh = {
    inputs,
    config,
    pkgs,
    ...
  }: let
    dir = "${config.home.homeDirectory}/nixos/modules/nvim/config";
    link = config.lib.file.mkOutOfStoreSymlink;
    system = pkgs.stdenv.hostPlatform.system;

    neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.default;

    plugins = with pkgs.vimPlugins; [
      # fennel
      hotpot-nvim

      # ai
      claudecode-nvim
      cord-nvim
      sidekick-nvim

      # colorscheme
      gruvbox-nvim

      # completion
      blink-cmp
      friendly-snippets

      # database
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui

      # editor
      auto-save-nvim
      guess-indent-nvim
      harpoon2
      nvim-autopairs
      nvim-surround
      oil-nvim
      plenary-nvim
      rainbow_csv
      render-markdown-nvim

      # format
      conform-nvim

      # git
      difftastic-nvim
      diffview-nvim
      git-conflict-nvim
      gitsigns-nvim
      nui-nvim

      # lsp
      nvim-lspconfig
      trouble-nvim

      # notes
      obsidian-nvim

      # rust
      crates-nvim
      rustaceanvim

      # snacks
      persistence-nvim
      snacks-nvim
      todo-comments-nvim

      # test
      neotest
      neotest-python
      nvim-nio

      # treesitter
      nvim-treesitter-context
      nvim-treesitter.withAllGrammars

      # typst
      typst-preview-nvim

      # ui
      bufferline-nvim
      lualine-nvim
      nvim-highlight-colors
      nvim-web-devicons
      which-key-nvim
    ];

    # packDir avoids wrapNeovim's LuaJIT env (nightly + nixpkgs plugins clash there)
    packDir = pkgs.vimUtils.packDir {myNeovimPackages.start = plugins;};

    neovim = pkgs.symlinkJoin {
      name = "neovim-nightly-with-plugins";
      paths = [neovim-nightly];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/nvim \
          --set NVIM_NIX_PLUGINS 1 \
          --add-flags "--cmd" \
          --add-flags "set packpath^=${packDir} | packloadall"
      '';
    };
  in {
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";

      # Fennel skips vim.pack when this is set; non-Nix leaves it unset
      NVIM_NIX_PLUGINS = "1";
    };

    home.packages = [neovim];

    xdg.configFile."nvim".source = link dir;
  };
}
