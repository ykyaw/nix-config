{
  flake.modules.nixos.nixos-desktop = { config, pkgs, ... }: {
    programs.hyprland.enable = true;

    services = {
      gnome.gnome-keyring.enable = true;
      greetd = {
        enable = true;
        settings =
          let
            hyprlandCommand = "${config.programs.hyprland.package}/bin/start-hyprland";
          in
          {
            initial_session = {
              command = hyprlandCommand;
              user = "thatoe";
            };
            default_session = {
              command = "${pkgs.greetd}/bin/agreety --cmd ${hyprlandCommand}";
              user = "greeter";
            };
          };
      };
    };

    security.pam.services.login.rules.session.fdeBootPassword = {
      order = config.security.pam.services.login.rules.session.gnome_keyring.order - 10;
      control = "optional";
      modulePath = "${pkgs.pam_fde_boot_pw}/lib/security/pam_fde_boot_pw.so";
      settings.inject_for = "gkr";
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  flake.modules.homeManager.nixos-desktop =
    { lib, pkgs, ... }:
    let
      inherit (lib.generators) mkLuaInline;
      toLua = lib.generators.toLua { };

      mkBind = keys: dispatcher: {
        _args = [
          keys
          (mkLuaInline dispatcher)
        ];
      };
      mkBindWith = flags: keys: dispatcher: {
        _args = [
          keys
          (mkLuaInline dispatcher)
          flags
        ];
      };
      mkMouseBind = mkBindWith { mouse = true; };
      mkMediaBind = mkBindWith {
        locked = true;
        repeating = true;
      };
      mkPlayerBind = mkBindWith { locked = true; };

      exec = cmd: "hl.dsp.exec_cmd(${toLua cmd})";

      directions = [
        {
          arrow = "left";
          vim = "H";
          dir = "l";
        }
        {
          arrow = "down";
          vim = "J";
          dir = "d";
        }
        {
          arrow = "up";
          vim = "K";
          dir = "u";
        }
        {
          arrow = "right";
          vim = "L";
          dir = "r";
        }
      ];
      directional =
        mods: dispatcher:
        lib.concatMap (
          d:
          map (key: mkBind "${mods} + ${key}" (dispatcher d.dir)) [
            d.arrow
            d.vim
          ]
        ) directions;

      workspaces = lib.range 1 10;
      workspaceBinds = lib.concatMap (
        i:
        let
          key = toString (lib.mod i 10);
        in
        [
          (mkBind "SUPER + ${key}" "hl.dsp.focus({ workspace = ${toString i} })")
          (mkBind "SUPER + CTRL + ${key}" "hl.dsp.window.move({ workspace = ${toString i} })")
        ]
      ) workspaces;

      monitors = [
        "DP-1"
        "DP-2"
      ];
      workspaceMonitor = i: lib.elemAt monitors (lib.mod (i - 1) (lib.length monitors));

      fullBleedWorkspaces = [
        {
          name = "wtv1";
          workspace = "w[tv1]";
        }
        {
          name = "f1";
          workspace = "f[1]";
        }
      ];
    in
    {
      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;

        settings = {
          config = {
            general = {
              border_size = 2;
              col = {
                active_border = {
                  colors = [
                    "rgba(33ccffee)"
                    "rgba(00ff99ee)"
                  ];
                  angle = 45;
                };
                inactive_border = "rgba(595959aa)";
              };
              layout = "master";
            };
            decoration.rounding = 0;
            ecosystem.no_donation_nag = true;
            input = {
              accel_profile = "flat";
              numlock_by_default = true;
            };
            misc = {
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
              mouse_move_enables_dpms = true;
            };
            xwayland.force_zero_scaling = true;
          };

          monitor = map (output: {
            inherit output;
            mode = "3840x2160@120";
          }) monitors;

          animation = [
            {
              leaf = "workspaces";
              enabled = false;
            }
          ];

          window_rule =
            map (ws: {
              name = "no-gaps-${ws.name}";
              match = {
                float = false;
                inherit (ws) workspace;
              };
              border_size = 0;
              rounding = 0;
            }) fullBleedWorkspaces
            ++ [
              {
                name = "suppress-maximize-events";
                match.class = ".*";
                suppress_event = "maximize";
              }
              {
                name = "fix-xwayland-drags";
                match = {
                  class = "^$";
                  title = "^$";
                  xwayland = true;
                  float = true;
                  fullscreen = false;
                  pin = false;
                };
                no_focus = true;
              }
            ];

          workspace_rule =
            map (i: {
              workspace = toString i;
              monitor = workspaceMonitor i;
            }) workspaces
            ++ map (ws: {
              inherit (ws) workspace;
              gaps_in = 0;
              gaps_out = 0;
            }) fullBleedWorkspaces;

          bind = [
            (mkBind "SUPER + Return" (exec "kitty"))
            (mkBind "SUPER + Space" (exec "fuzzel"))
            (mkBind "SUPER + Q" "hl.dsp.window.close()")
            (mkBind "SUPER + SHIFT + E" (
              exec "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
            ))
            (mkBind "SUPER + SHIFT + P" "hl.dsp.dpms()")
            (mkBind "SUPER + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })'')
            (mkBind "SUPER + M" ''hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })'')
            (mkBind "SUPER + CTRL + Space" ''hl.dsp.window.float({ action = "toggle" })'')
            (mkBind "SUPER + A" ''hl.dsp.layout("focusmaster")'')
            (mkBind "SUPER + CTRL + A" ''hl.dsp.layout("swapwithmaster")'')
          ]
          ++ directional "SUPER" (dir: ''hl.dsp.focus({ direction = "${dir}" })'')
          ++ directional "SUPER + CTRL" (dir: ''hl.dsp.window.move({ direction = "${dir}" })'')
          ++ directional "SUPER + SHIFT" (dir: ''hl.dsp.focus({ monitor = "${dir}" })'')
          ++ directional "SUPER + CTRL + SHIFT" (dir: ''hl.dsp.window.move({ monitor = "${dir}" })'')
          ++ workspaceBinds
          ++ [
            (mkBind "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
            (mkBind "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')
            (mkBind "SUPER + S" ''hl.dsp.workspace.toggle_special("scratchpad")'')
            (mkBind "SUPER + CTRL + S" ''hl.dsp.window.move({ workspace = "special:scratchpad" })'')
            (mkMouseBind "SUPER + mouse:272" "hl.dsp.window.drag()")
            (mkMouseBind "SUPER + mouse:273" "hl.dsp.window.resize()")
            (mkMediaBind "XF86AudioRaiseVolume" (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
            (mkMediaBind "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
            (mkMediaBind "XF86AudioMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
            (mkMediaBind "XF86AudioMicMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
            (mkPlayerBind "XF86AudioPlay" (exec "playerctl play-pause"))
            (mkPlayerBind "XF86AudioPause" (exec "playerctl play-pause"))
            (mkPlayerBind "XF86AudioStop" (exec "playerctl stop"))
            (mkPlayerBind "XF86AudioNext" (exec "playerctl next"))
            (mkPlayerBind "XF86AudioPrev" (exec "playerctl previous"))
          ];
        };
      };

      home.packages = [ pkgs.playerctl ];

      programs.fuzzel.enable = true;
    };
}
