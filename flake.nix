{
  description = "anirudh's nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # advent of code cli (my fork)
    aoc-cli = {
      url = "github:kidskoding/aoc-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # coding agents
    antigravity-cli = {
      url = "github:Hy4ri/antigravity-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code-cli = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
    codex-cli = {
      url = "github:sadjow/codex-cli-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";

    # coding agent skills, plugins, settings
    anikonistack = {
      url = "github:kidskoding/anikonistack";
      inputs.claude-code-nix.follows = "claude-code-cli";
    };

    # rust tooling
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # vite-plus
    nix-vite-plus = {
      url = "github:ryoppippi/nix-vite-plus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri
    niri.url = "github:sodiboo/niri-flake";

    # noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix: nix in style 💎!!
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # disko: declarative disk layout!
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets (sops)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # productivity
    matui.url = "github:pkulak/matui"; # matrix tui client
    toofan.url = "github:vyrx-dev/toofan";

    # browsers
    cromite = {
      url = "github:Impqxr/cromite-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {nixpkgs, ...}: let
    mkHost = name:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/${name}
          ./configuration.nix
        ];
      };
  in {
    templates = {
      uv2nix = {
        path = ./templates/uv2nix;
        description = "python project built from uv.lock";
      };

      bun2nix = {
        path = ./templates/bun2nix;
        description = "bun project built from bun.lock";
      };

      pnpm2nix = {
        path = ./templates/pnpm2nix;
        description = "pnpm project built from pnpm-lock.yaml";
      };

      crane = {
        path = ./templates/crane;
        description = "rust project built from Cargo.lock";
      };

      bundix = {
        path = ./templates/bundix;
        description = "ruby project built from Gemfile.lock";
      };

      gomod2nix = {
        path = ./templates/gomod2nix;
        description = "go project built from go.sum";
      };

      elm2nix = {
        path = ./templates/elm2nix;
        description = "elm project built from elm.json";
      };

      gradle2nix = {
        path = ./templates/gradle2nix;
        description = "gradle project built from gradle.lock";
      };
    };

    nixosConfigurations = {
      victus = mkHost "victus";
      # thinkpad = mkHost "thinkpad";
    };
  };
}
