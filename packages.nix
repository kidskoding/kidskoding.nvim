{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;

  thinkrail = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "thinkrail";
    version = "0.2.0";
    src = pkgs.fetchurl {
      url = "https://github.com/JetBrains/thinkrail/releases/download/v${version}/thinkrail-linux-x64";
      hash = "sha256-VA99RiWEkWExin2wU3GbGbQgHrf86vTdVWykx+CIAQw=";
    };
    dontUnpack = true;
    dontStrip = true;
    dontPatchELF = true;
    installPhase = "install -Dm755 $src $out/bin/thinkrail";
  };
in {
  home.packages = [
    inputs.aoc-cli.packages.${system}.default

    inputs.antigravity-cli.packages.${system}.default
    inputs.claude-code-cli.packages.${system}.default
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
    inputs.codex-cli.packages.${system}.default

    # coding agents (used within llm-agents package!)
    # inputs.llm-agents.packages.${system}.coco             # snowflake, cortex code cli!
    inputs.llm-agents.packages.${system}.copilot-cli # github copilot cli
    # inputs.llm-agents.packages.${system}.cline            # autonomous coding agent cli!
    # inputs.llm-agents.packages.${system}.crush            # charmbracelet's glamourous ai coding agent!
    inputs.llm-agents.packages.${system}.cursor-agent # cursor/spacexai's coding agent cli!
    # inputs.llm-agents.packages.${system}.grok             # spacexai's/xai's coding agent cli!
    # inputs.llm-agents.packages.${system}.junie            # jetbrains's ai coding agent cli!
    # inputs.llm-agents.packages.${system}.mistral-vibe     # mistral ai's minimal coding agent cli!
    inputs.llm-agents.packages.${system}.orca # a wonderful ade for working with many coding agents!
    inputs.llm-agents.packages.${system}.pi # a wonderful agent harness!
    thinkrail # jetbrains's spec-first agentic ide, runs pi in the browser!
    # inputs.llm-agents.packages.${system}.qwen-code          # agent cli / workflow tool for the family of Qwen3 models!

    # ai assistants
    inputs.llm-agents.packages.${system}.hermes-agent # hermes-agent cli!
    inputs.llm-agents.packages.${system}.hermes-desktop # hermes-agent desktop!

    # rust nightly toolchain
    (inputs.fenix.packages.${system}.latest.withComponents [
      "cargo"
      "clippy"
      "rust-analyzer"
      "rust-src"
      "rustc"
      "rustfmt"
    ])

    inputs.nix-vite-plus.packages.${system}.default

    inputs.matui.packages.${system}.default
    inputs.toofan.packages.${system}.default

    # artcraft apps
    # inputs.artcraft-nix.packages.${system}.cadcraft     # autocad clone
    inputs.artcraft-nix.packages.${system}.deckcraft # powerpoint clone
    # inputs.artcraft-nix.packages.${system}.designcraft  # indesign clone
    # inputs.artcraft-nix.packages.${system}.effectcraft  # after effects clone
    # inputs.artcraft-nix.packages.${system}.filmcraft    # premiere pro clone
    inputs.artcraft-nix.packages.${system}.gridcraft # excel clone
    # inputs.artcraft-nix.packages.${system}.lightcraft   # lightroom clone
    inputs.artcraft-nix.packages.${system}.pdfcraft # acrobat clone
    # inputs.artcraft-nix.packages.${system}.photocraft   # photoshop clone
    inputs.artcraft-nix.packages.${system}.soundcraft # pro tools clone
    # inputs.artcraft-nix.packages.${system}.vectorcraft  # illustrator clone
    inputs.artcraft-nix.packages.${system}.wordcraft # word clone

    inputs.cromite.packages.${system}.default
    inputs.zen-browser.packages.${system}.default
  ];
}
