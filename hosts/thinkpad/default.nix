{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "thinkpad";

  system.stateVersion = "26.11";
}
