{lib, ...}: let
  inherit (lib) mkOption types;
in {
  flake.nixosModules.base.options.my = {
    gpu = mkOption {
      type = types.listOf (types.enum ["amd" "intel" "nvidia"]);
      default = [];
    };

    display = {
      output = mkOption {
        type = types.str;
        default = "eDP-1";
      };
      width = mkOption {type = types.int;};
      height = mkOption {type = types.int;};
      refresh = mkOption {
        type = types.nullOr types.float;
        default = null;
      };
      vrr = mkOption {
        type = types.bool;
        default = false;
      };
      scale = mkOption {
        type = types.float;
        default = 1.0;
      };
      textScale = mkOption {
        type = types.float;
        default = 1.0;
      };
    };
  };
}
