{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./disko.nix
    ./nvidia.nix
  ];

  networking.hostName = "victus";

  system.stateVersion = "26.05";
}
