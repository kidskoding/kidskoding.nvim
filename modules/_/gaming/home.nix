{pkgs, ...}: {
  imports = [./mangohud.nix];

  home.packages = with pkgs; [
    prismlauncher
    wineWow64Packages.stable
    winetricks

    # gaming deps
    bottles
    dolphin-emu
    heroic
    lutris
  ];
}
