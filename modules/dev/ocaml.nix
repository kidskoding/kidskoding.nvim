{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      ocaml
      dune_3
      ocamlPackages.ocaml-lsp
      ocamlformat
    ];
  };
}
