{
  description = "gradle project built from gradle.lock";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    gradle2nix = {
      url = "github:tadfisher/gradle2nix/v2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    jdk = pkgs.jdk21;
    gradle = pkgs.gradle.override {java = jdk;};
  in {
    packages.${system}.default = pkgs.callPackage ./default.nix {
      inherit gradle jdk;
      inherit (inputs.gradle2nix.builders.${system}) buildGradlePackage;
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = [
        jdk
        gradle
        inputs.gradle2nix.packages.${system}.gradle2nix
      ];

      env = {
        JAVA_HOME = jdk;
        GRADLE_USER_HOME = ".gradle";
      };

      shellHook = ''
        [ -d .git ] || git init -q

        if ! ls settings.gradle* build.gradle* >/dev/null 2>&1; then
          gradle init --use-defaults --overwrite --type kotlin-application --dsl kotlin
        fi

        if [ ! -f gradle.lock ] || find . -maxdepth 2 -type f \( -name '*.gradle' -o -name '*.gradle.kts' -o -name libs.versions.toml \) -newer gradle.lock | grep -q .; then
          gradle2nix
        fi
      '';
    };
  };
}
