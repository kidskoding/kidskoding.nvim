{
  config,
  pkgs,
  inputs,
  host,
  ...
}: {
  imports = [
    ./networking.nix

    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};
    users.anirudh = {
      imports = [
        ./home-manager/home.nix
        inputs.sops-nix.homeManagerModules.sops
      ];

      sops = {
        defaultSopsFile = ./secrets/secrets.yaml;
        age.keyFile = "/home/anirudh/.config/sops/age/keys.txt";
      };
    };
  };

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/anirudh/.config/sops/age/keys.txt";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # do not warn if git tree is dirty when rebuilding system
  nix.settings.warn-dirty = false;

  # prebuilt nix-community builds
  # instead of compiling from source
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://devenv.cachix.org"
    "https://noctalia.cachix.org"
    "https://pkulak.cachix.org"
    "https://cache.numtide.com"
  ];
  nix.settings.trusted-public-keys = [
    # bun2nix trusted public key
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

    # devenv trusted public key
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="

    # noctalia trusted public key
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="

    # matui trusted public key
    "pkulak.cachix.org-1:S25jAptWCkAmwrk41b47lheB9onW9mzxVqM9o6HRg1E="

    # llm-agents trusted public key
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
  ];

  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults pwfeedback
    '';
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.gnome.gparted" &&
            subject.isInGroup("wheel") && subject.local && subject.active) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.upower.enable = true;
  services.upower.criticalPowerAction = "Hibernate";

  zramSwap.enable = true;
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];
  services.logind.settings.Login.HandleLidSwitch = "lock";

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users = {
    "anirudh" = {
      isNormalUser = true;
      description = "Anirudh Konidala";

      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    gcc
    gdb
    git
    gparted
    pkg-config
    psmisc
    python315
    sops
    unzip
    vim
    wget

    # apt build-essential
    stdenv.cc
    gnumake
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # run prebuilt binaries (uv-managed pythons, pip wheels, etc.) when necessary
  programs.nix-ld.enable = true;

  systemd.globalEnvironment = {
    SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  };

  boot.supportedFilesystems = ["btrfs" "fuse"];
  programs.fuse.userAllowOther = true;

  # nautilus: trash, mounts, and settings storage
  services.gvfs.enable = true;
  programs.dconf.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # run electron/chromium apps (discord, spotify) natively on wayland
  # instead of xwayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.etc."flake-host".text = host;

  system.autoUpgrade = {
    enable = true;
    flake = "git+https://codeberg.org/kidskoding/nixos-config?ref=master#${host}";
    flags = ["-L"];
    dates = "hourly";
    randomizedDelaySec = "10min";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  systemd.services.nixos-upgrade.preStart = ''
    ${pkgs.util-linux}/bin/runuser -u anirudh -- ${pkgs.bash}/bin/bash -c '
      export HOME=/home/anirudh
      cd /home/anirudh/nixos || exit 0
      git pull --ff-only || exit 0
      nix flake update anikonistack --commit-lock-file || exit 0
      git push || true
    '
  '';
}
