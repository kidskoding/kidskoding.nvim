{
  lib,
  stdenv,
  nodejs,
  pnpm_11,
  fetchPnpmDeps,
  pnpmConfigHook,
  pnpmBuildHook,
}: let
  packageJson = builtins.fromJSON (builtins.readFile ./package.json);
  pnpm = pnpm_11;
in
  stdenv.mkDerivation (finalAttrs: {
    pname = packageJson.name;
    version = packageJson.version or "0.1.0";

    src = ./.;

    nativeBuildInputs = [
      nodejs
      pnpm
      pnpmConfigHook
      pnpmBuildHook
    ];

    pnpmDeps = fetchPnpmDeps {
      inherit (finalAttrs) pname version src;
      inherit pnpm;
      fetcherVersion = 4;
      hash = lib.fakeHash;
    };

    installPhase = ''
      runHook preInstall
      cp -r dist $out
      runHook postInstall
    '';
  })
