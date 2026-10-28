{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      dockerfile-language-server
      fish-lsp
      shellcheck
      sqls
      taplo
      terraform-ls
      yaml-language-server

      duckdb
    ];
  };
}
