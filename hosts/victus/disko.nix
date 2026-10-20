{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1";

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          device = "/dev/disk/by-uuid/7F7C-B7FF";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };

        root = {
          size = "100%";
          device = "/dev/disk/by-uuid/a9b8176d-aa1c-458f-8e4d-c6c3cbd55d72";
          content = {
            type = "btrfs";
            mountpoint = "/";
            subvolumes = {
              nix.mountpoint = "/nix";
              home.mountpoint = "/home";
            };
          };
        };

        swap = {
          size = "9G";
          device = "/dev/disk/by-uuid/ba070d83-ab66-4574-b2c9-009acb712972";
          content.type = "swap";
        };
      };
    };
  };
}
