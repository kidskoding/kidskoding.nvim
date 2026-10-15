{config, ...}: let
  c = config.lib.stylix.colors;
  rgb = base: "38;2;${c."${base}-rgb-r"};${c."${base}-rgb-g"};${c."${base}-rgb-b"}";
  red = "{#${rgb "base08"}}";
  orange = "{#${rgb "base09"}}";
  yellow = "{#${rgb "base0A"}}";
  green = "{#${rgb "base0B"}}";
  cyan = "{#${rgb "base0C"}}";
  blue = "{#${rgb "base0D"}}";
  magenta = "{#${rgb "base0E"}}";
  nixosBlue = "38;2;82;119;195";
  nixosBlueLight = "38;2;126;186;228";
in {
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "small";
        /*
           color = {
          "1" = nixosBlue;
          "2" = nixosBlueLight;
          "3" = nixosBlue;
          "4" = nixosBlueLight;
          "5" = nixosBlue;
          "6" = nixosBlueLight;
        };
        */
        padding = {
          top = 5;
          left = 3;
        };
      };

      display = {
        separator = " ";
        color.keys = rgb "base04";
      };

      modules = [
        {
          type = "custom";
          key = "╭───────────╮";
        }
        {
          type = "title";
          key = "│ ${blue} user    {#keys}│";
          format = "{user-name}";
        }
        {
          type = "title";
          key = "│ ${cyan}󰇅 hname   {#keys}│";
          format = "{host-name}";
        }
        {
          type = "os";
          key = "│ ${green}{icon} distro  {#keys}│";
        }
        {
          type = "kernel";
          key = "│ ${yellow} kernel  {#keys}│";
        }
        {
          type = "packages";
          key = "│ ${orange}󰏗 pkgs    {#keys}│";
        }
        {
          type = "wm";
          key = "│ ${red}󰖲 wm      {#keys}│";
        }
        {
          type = "custom";
          key = "│ ${magenta} toolkit {#keys}│";
          format = "noctalia ${config.programs.noctalia.package.version}";
        }
        {
          type = "custom";
          key = "│ ${blue}󰏘 theme   {#keys}│";
          format = c.scheme;
        }
        {
          type = "custom";
          key = "│ ${cyan} font    {#keys}│";
          format = config.stylix.fonts.monospace.name;
        }
        {
          type = "terminal";
          key = "│ ${green} term    {#keys}│";
        }
        {
          type = "shell";
          key = "│ ${yellow} shell   {#keys}│";
        }
        {
          type = "host";
          key = "│ ${orange} host    {#keys}│";
        }
        {
          type = "cpu";
          key = "│ ${red}󰍛 cpu     {#keys}│";
          format = "{name}";
        }
        {
          type = "gpu";
          key = "│ ${magenta}󰍛 gpu     {#keys}│";
          format = "{1} {2}";
          hideType = "integrated";
        }
        {
          type = "memory";
          key = "│ ${blue} memory  {#keys}│";
        }
        {
          type = "disk";
          key = "│ ${cyan}󰉉 disk    {#keys}│";
          folders = "/";
        }
        {
          type = "custom";
          key = "├───────────┤";
        }
        {
          type = "custom";
          key = "│ {#39} colors  {#keys}│";
          format = "${blue}██${cyan}██${green}██${yellow}██${orange}██${red}██${magenta}██{#}";
        }
        {
          type = "custom";
          key = "╰───────────╯";
        }
      ];
    };
  };
}
