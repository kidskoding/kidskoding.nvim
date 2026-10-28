{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    home.packages = with pkgs; [
      claude-agent-acp
      codex-acp
    ];
  };
}
