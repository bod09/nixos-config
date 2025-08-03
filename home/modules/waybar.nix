{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        spacing = 4;
        margin-top = 4;
        margin-left = 4;
        margin-right = 4;
        margin-bottom = 0;
        modules-left = ["custom/startmenu" "hyprland/workspaces" "tray" "mpris"];
        modules-center = ["hyprland/window"];
        modules-right = ["wireplumber" "hyprland/language" "battery" "network" "clock" "custom/notification"];

        "custom/startmenu" = {
          format = "{icon}";
          format-icons = "󱄅";
          tooltip = false;
          on-click = "rofi -show drun";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰲠";
            "2" = "󰲢";
            "3" = "󰲤";
            "4" = "󰲦";
            "5" = "󰲨";
            "6" = "󰲪";
            "7" = "󰲬";
            "8" = "󰲮";
            "9" = "󰲰";
            active = "";
            default = "";
          };
        };
        "mpris" = {
          interval = 1;
        	format = "{player_icon} {title} <span size='small'>[{position}/{length}]</span>";
        	format-paused = "{status_icon} {title} <span size='small'>{position}/{length}</span>";
        	player-icons = {
        		"default" = "▶";
        		"plex" = "󰚺";
            "spotify" = "<span color='#1DB954'></span>";
        	};
        	status-icons = {
        		"paused" = "⏸";
        	};
        };
        "hyprland/window" = {
          format = "{class}";
          separate-outputs = true;
        };
        "wireplumber" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = ["" "" ""];
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; 
        };
        "hyprland/language" = {
          format = " {short} {variant}";
          on-click = "";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "{icon} {capacity}%";
          format-plugged = "";
          format-icons = {
            "discharging" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            "charging" = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
          };
        };
        "network" = {
          format = "{ifname}";
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "󰤮 Disconnected";
          tooltip-format = "󰊗 {ifname} via {gwaddr}";
          tooltip-format-wifi = " {essid} ({signalStrength}%)";
          tooltip-format-ethernet = "󰈀 {ifname}: {ipaddr}/{cidr}";
          tooltip-format-disconnected = "󰤮 Disconnected";
          on-click = "kitty -e nmtui";
        };
        "clock" = {
          format = " {:%H:%M}";
          tooltip-format = "{:%b-%d}";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          return-type ="json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right ="swaync-client -d -sw";
          escape = true;
        };
      };
    };
     style = ''
      * {
        all: unset;
        font-family: "JetBrainsMono Nerd Font Propo", FontAwesome, Sans-serif;
        font-size: 16px;
        min-height: 0;
        color: @text;
      }

      window#waybar {
        border-radius: 16px;
      	background: rgba(24, 24, 37, 0.75);
      }

      /* Make window module transparent when no windows present */
      window#waybar.empty #window {
        background-color: transparent;
      }

      #custom-startmenu, #workspaces, #tray, #mpris, #window, #wireplumber, #language, #battery, #network, #clock, #custom-notification, tooltip, #tray menu {
        background-color: @base;
        border-radius: 14px;
        padding: 4px 12px;
        opacity: 1;
      }
      #workspaces button {
        padding: 0 8px;
      }

      /*
       * ---- Battery ----
       */
      
      #battery.warning {
          color: @peach;
      }
      
      #battery.critical {
          color: @red;
      }
    '';
  };
}
