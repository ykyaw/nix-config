{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        border_size = 3;
        gaps_out = 5;
        "col.inactive_border" = "rgba(595959aa)";
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        cursor_inactive_timeout = 5;
        layout = "master";
      };
      decoration = {
        drop_shadow = false;
      };
      input = {
        numlock_by_default = true;
        accel_profile = "flat";
      };
      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        vrr = 2;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
      };
      monitor = ",3840x2160@120,0x0,1,bitdepth,10";
      opengl = {
        nvidia_anti_flicker = false;
      };
      exec-once = [
        "${pkgs.kwallet-pam}/libexec/pam_kwallet_init"
      ];
      bind = [
        "SUPER, Return, exec, kitty"
        "SUPER, B, exec, brave"
        "SUPER, C, exec, code"
        "SUPER, E, exec, dolphin"
        "SUPER, space, exec, pkill rofi || rofi -show drun"
        "SUPER, Tab, workspace, previous"
        "SUPER CTRL, C, exec, bash -c '${pkgs.killall}/bin/killall ${pkgs.xdotool}/bin/xdotool || while ${pkgs.xdotool}/bin/xdotool click --repeat 10 --delay 100 1; do :; done'"
        ", Print, exec, ${pkgs.grim}/bin/grim -g \"${pkgs.slurp}/bin/slurp -d\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"

        "SUPER SHIFT,Q,killactive"
        "SUPER SHIFT,space,togglefloating"
        "SUPER, F, fullscreen"

        "SUPER, H, movefocus,l"
        "SUPER, J, movefocus,d"
        "SUPER, K, movefocus,u"
        "SUPER, L, movefocus,r"
        "SUPER, Left, movefocus,l"
        "SUPER, Down, movefocus,d"
        "SUPER, Up, movefocus,u"
        "SUPER, Right, movefocus,r"

        "SUPER SHIFT, H, movewindow,l"
        "SUPER SHIFT, J, movewindow,d"
        "SUPER SHIFT, K, movewindow,u"
        "SUPER SHIFT, L, movewindow,r"
        "SUPER SHIFT, Left, movewindow,l"
        "SUPER SHIFT, Down, movewindow,d"
        "SUPER SHIFT, Up, movewindow,u"
        "SUPER SHIFT, Right, movewindow,r"

        "SUPER, M, layoutmsg, focusmaster"
        "SUPER SHIFT, M, layoutmsg, swapwithmaster"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"
      ];
      bindm = [
        "Super, mouse:272, movewindow"
        "Super, mouse:273, resizewindow"
      ];
      windowrulev2 = [
        "workspace 1 silent, class:(brave-browser)"
        "workspace 2 silent, class:(code-url-handler)"
        "workspace 3 silent, class:(GitKraken)"
        "workspace 3 silent, class:(novadesdk)"
        "workspace 4 silent, class:(teams-for-linux)"
        "workspace 4 silent, class:(discord)"
        "workspace 5 silent, class:(Spotify)"
        "workspace 6 silent, class:(steam)"
      ];
      master = {
        new_is_master = false;
        no_gaps_when_only = 1;
      };
      env = [
        "__GLX_VENDOR_LIBRARY_NAME, nvidia"
        "GBM_BACKEND, nvidia-drm"
        "NIXOS_OZONE_WL, 1"
        "WLR_NO_HARDWARE_CURSORS, 1"
      ];
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 60;
        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
