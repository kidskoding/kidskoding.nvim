{
  lib,
  buildGoApplication,
}: let
  goMod = lib.splitString "\n" (builtins.readFile ./go.mod);
  module = lib.removePrefix "module " (lib.findFirst (lib.hasPrefix "module ") "module app" goMod);
in
  buildGoApplication {
    pname = lib.last (lib.splitString "/" module);
    version = "0.1.0";

    src = ./.;
    pwd = ./.;
    modules = ./gomod2nix.toml;
  }
