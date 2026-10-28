# languages too small for their own file yet
{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      dotnet-sdk_11
      omnisharp-roslyn

      elmPackages.elm
      elmPackages.elm-language-server

      (julia.withPackages ["LanguageServer"])

      php
      phpPackages.composer
      intelephense

      ruby
      ruby-lsp

      swift
      swiftpm
      sourcekit-lsp

      zig
      zls
    ];
  };
}
