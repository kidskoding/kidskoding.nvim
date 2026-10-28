{inputs, ...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.sessionVariables.TSDK = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";

    home.packages = with pkgs; [
      bun
      nodejs
      typescript
      inputs.nix-vite-plus.packages.${pkgs.stdenv.hostPlatform.system}.default

      graphql-language-service-cli
      mdx-language-server
      vscode-langservers-extracted

      prettier
      stylelint
    ];
  };
}
