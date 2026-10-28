{inputs, ...}: {
  flake.homeModules.anirudh = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    home.packages = with pkgs; [
      # rust nightly toolchain
      (inputs.fenix.packages.${system}.latest.withComponents [
        "cargo"
        "clippy"
        "rust-analyzer"
        "rust-src"
        "rustc"
        "rustfmt"
      ])

      bacon
      cargo-generate
      cargo-info
      cargo-seek
      irust
      rusty-man
    ];
  };
}
