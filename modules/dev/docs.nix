{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      typst
      tinymist
      typstyle

      marksman
      mdbook
      mdbook-mermaid
      pandoc
    ];
  };
}
