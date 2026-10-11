{
  config,
  pkgs,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
in {
  programs.noctalia.settings = {
    bar.main = {
      position = "top";
      margin_edge = 10;
      margin_ends = 12;
      thickness = 44;
      radius = 16;
      padding = 12;
      widget_spacing = 12;
      font_scale = 1.1;
      scale = 1.1;
      background_opacity = 0.85;
      capsule = true;
      capsule_fill = "surface_variant";
      color = "on_surface";
      capsule_border_width = 0;
      capsule_padding = 8;
      capsule_thickness = 0.8;

      dead_zone.actions.right = "none";

      start = ["control-center" "workspaces"];
      center = ["media"];
      end = [
        "tray"
        "volume"
        "network"
        "brightness"
        "battery"
        "group:datetime"
        "session"
      ];

      capsule_group = [
        {
          id = "datetime";
          members = ["date-icon" "date" "datetime-sep" "time-icon" "clock"];
          widget_spacing = 6;
        }
      ];
    };

    widget = {
      tray.drawer = true;

      workspaces = {
        capsule = false;
        style = "regular";
        capsule_radius = 0;
        scale = 1.5;
        font_weight = 700;
        active_pill_size = 1;
        inactive_pill_size = 1;
        label_source = "id";
        hide_when_empty = true;
        occupied_color = c.base04;
      };

      media = {
        artist_first = false;
        max_length = 300;
        title_scroll = "always";
        hide_when_no_media = true;
        show_progress = true;
      };

      volume = {
        show_label = true;
        icon_color = "tertiary";
      };
      network = {
        show_label = true;
        show_vpn_label = false;
        icon_color = c.base0C;
      };
      brightness = {
        show_label = true;
        icon_color = c.base0A;
      };
      battery = {
        display_mode = "glyph";
        show_label = true;
        icon_color = "secondary";
      };

      date-icon = {
        type = "custom_button";
        glyph = "calendar";
        icon_color = c.base08;
        interactive = false;
      };
      date = {
        type = "clock";
        format = "{:%a %b %d}";
        tooltip_format = "{:%A, %B %-d %Y}";
        actions.left = "panel-toggle control-center calendar";
      };
      datetime-sep = {
        type = "text";
        text = "|";
        color = "on_surface_variant";
        interactive = false;
      };
      time-icon = {
        type = "custom_button";
        glyph = "clock";
        icon_color = c.base08;
        interactive = false;
      };
      clock = {
        format = "{:%I:%M %p}";
        tooltip_format = "{:%A, %B %-d %Y}";
        actions.left = "panel-toggle control-center calendar";
      };

      control-center = {
        capsule = true;
        custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        custom_image_colorize = false;
      };

      session = {
        glyph = "shutdown";
        capsule = true;
        capsule_fill = "error";
        icon_color = "on_error";
        actions.left = "panel-toggle session";
      };
    };
  };
}
