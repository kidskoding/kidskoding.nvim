{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      lua
      luarocks
      luaPackages.fennel

      fennel-ls
      lua-language-server

      fnlfmt
      stylua
    ];
  };
}
