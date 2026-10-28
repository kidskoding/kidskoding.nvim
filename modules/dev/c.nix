{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      bear
      cmake
      libtool
      xmake

      # niche c / c++ tooling
      clang-tools
      ninja
      pkg-config
      valgrind

      doxygen
    ];
  };
}
