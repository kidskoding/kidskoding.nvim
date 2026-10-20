{lib, ...}: {
  imports = [
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" "anirudh"])

    ./niri
    ./noctalia
  ];
}
