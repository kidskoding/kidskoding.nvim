{
  buildGradlePackage,
  gradle,
  jdk,
  makeWrapper,
}:
buildGradlePackage {
  pname = "app";
  version = "0.1.0";

  src = ./.;
  lockFile = ./gradle.lock;

  inherit gradle;
  buildJdk = jdk;

  nativeBuildInputs = [makeWrapper];

  gradleBuildFlags = ["installDist"];

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    for dist in build/install/* */build/install/*; do
      [ -d "$dist" ] && cp -r "$dist"/. $out
    done
    rm -f $out/bin/*.bat
    for bin in $out/bin/*; do
      wrapProgram "$bin" --set JAVA_HOME ${jdk}
    done
    runHook postInstall
  '';
}
