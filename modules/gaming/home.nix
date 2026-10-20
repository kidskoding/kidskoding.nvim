{pkgs, ...}: {
  imports = [./mangohud.nix];

  home.packages = with pkgs; [
    bottles
    dolphin-emu
    heroic
    lutris
    prismlauncher
    wineWow64Packages.stable
    winetricks
  ];
}
