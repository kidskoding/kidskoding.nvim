{...}: {
  flake.nixosModules.base = {
    config,
    lib,
    ...
  }:
    lib.mkIf (lib.elem "amd" config.my.gpu) {
      hardware.amdgpu.initrd.enable = true;
      boot.kernelParams = ["amdgpu.dcdebugmask=0x10" "amdgpu.sg_display=0"];
    };
}
