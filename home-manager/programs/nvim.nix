{config, ...}: {
  # Neovim is maintained as a Git subtree; link it live for edits without rebuilds.
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos/programs/nvim";
}
