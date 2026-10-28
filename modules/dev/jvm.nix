{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      jdk21
      gradle
      scala_3

      jdt-language-server
      kotlin-language-server
      metals
    ];
  };
}
