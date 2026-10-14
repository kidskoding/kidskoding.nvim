{
  stdenv,
  elmPackages,
}:
stdenv.mkDerivation {
  pname = "app";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [elmPackages.elm];

  configurePhase = elmPackages.fetchElmDeps {
    elmPackages = import ./elm-srcs.nix;
    elmVersion = elmPackages.elm.version;
    registryDat = ./registry.dat;
  };

  buildPhase = ''
    elm make src/Main.elm --optimize --output main.js
  '';

  installPhase = ''
    mkdir $out
    cp main.js $out
    if [ -f index.html ]; then cp index.html $out; fi
  '';
}
