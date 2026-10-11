{
  pkgs,
  fenix,
}: let
  toolchain = fenix.stable.withComponents [
    "cargo"
    "clippy"
    "rust-analyzer"
    "rust-src"
    "rustc"
    "rustfmt"
  ];
in
  pkgs.mkShell {
    packages =
      [toolchain]
      ++ (with pkgs; [
        bacon
        cargo-chef
        cargo-generate
        cargo-seek
        irust
        trunk
        wasm-pack
      ]);

    RUST_BACKTRACE = "1";
  }
