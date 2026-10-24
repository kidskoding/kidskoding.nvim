{...}: {
  flake.homeModules.anirudh = {
    programs.zellij = {
      enable = true;
      enableFishIntegration = false;

      layouts.default = ''
        layout {
          default_tab_template {
            pane size=1 borderless=true {
              plugin location="zellij:compact-bar"
            }
            children
          }
        }
      '';

      settings = {
        copy_command = "wl-copy";
        show_startup_tips = false;
        pane_frame_style = "full";

        keybinds = {
          unbind = [
            "Ctrl g"
            "Ctrl p"
            "Ctrl n"
            "Ctrl t"
            "Ctrl s"
            "Ctrl o"
            "Ctrl h"
            "Ctrl b"
            "Ctrl q"
          ];

          normal = {
            "bind \"Alt x\"" = {
              CloseFocus = [];
            };
            "bind \"Alt s\"" = {
              NewPane = "stacked";
            };
            "bind \"Alt n\"" = {
              NewPane = "right";
            };
            "bind \"Alt d\"" = {
              NewPane = "down";
            };
            "bind \"Alt t\"" = {
              NewTab = [];
            };
            "bind \"Alt f\"" = {
              ToggleFocusFullscreen = [];
            };
            "bind \"Alt w\"" = {
              ToggleFloatingPanes = [];
            };
            "bind \"Alt m\"" = {
              MovePane = "right";
            };

            "bind \"Alt h\" \"Alt Left\"" = {
              MoveFocus = "Left";
            };
            "bind \"Alt l\" \"Alt Right\"" = {
              MoveFocus = "Right";
            };

            "bind \"Alt H\" \"Alt Shift h\" \"Alt K\" \"Alt Shift k\" \"Alt Shift Left\" \"Alt Shift Up\"" = {
              GoToPreviousTab = [];
            };
            "bind \"Alt L\" \"Alt Shift l\" \"Alt J\" \"Alt Shift j\" \"Alt Shift Right\" \"Alt Shift Down\"" = {
              GoToNextTab = [];
            };
          };
        };
      };
    };
  };
}
