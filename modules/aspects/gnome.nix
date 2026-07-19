{
  flake.modules.nixos.nixos-desktop = { pkgs, ... }: {
    services = {
      displayManager = {
        autoLogin = {
          enable = true;
          user = "thatoe";
        };
        gdm.enable = true;
      };
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      decibels
      epiphany
      gnome-characters
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-maps
      gnome-music
      gnome-tecla
      gnome-tour
      showtime
      snapshot
      totem
      yelp
    ];
  };

  flake.modules.homeManager.nixos-desktop =
    { pkgs, lib, ... }:
    let
      extensions = with pkgs.gnomeExtensions; [
        appindicator
        blur-my-shell
        caffeine
        hot-edge
      ];
      gvariant = lib.hm.gvariant;
      mkWorldClock =
        name: code: lat: lon: latAccuracy: lonAccuracy:
        gvariant.mkVariant (
          gvariant.mkTuple [
            (gvariant.mkUint32 2)
            (gvariant.mkVariant (
              gvariant.mkTuple [
                name
                code
                true
                (gvariant.mkArray
                  (gvariant.type.tupleOf [
                    gvariant.type.double
                    gvariant.type.double
                  ])
                  [
                    (gvariant.mkTuple [
                      lat
                      lon
                    ])
                  ]
                )
                (gvariant.mkArray
                  (gvariant.type.tupleOf [
                    gvariant.type.double
                    gvariant.type.double
                  ])
                  [
                    (gvariant.mkTuple [
                      latAccuracy
                      lonAccuracy
                    ])
                  ]
                )
              ]
            ))
          ]
        );
      worldClocks = [
        (mkWorldClock "Abingdon" "KVJI" 0.64024494145548905 (-1.4317517572349174) 0.64070747116056015 (
          -1.4307746346531884
        ))
        (mkWorldClock "London" "EGWU" 0.89971722940307675 (-0.007272211034407213) 0.89884456477707964 (
          -0.0020362232784242244
        ))
        (mkWorldClock "Singapore" "WSAP" 0.023852838928353343 1.8136879868485383 0.022568084612667797
          1.8126262332513803
        )
      ];
    in
    {
      home.packages = extensions;

      dconf = {
        enable = true;
        settings = {
          "org/gnome/clocks".world-clocks = gvariant.mkArray "a{sv}" (
            map (
              loc:
              gvariant.mkArray "{sv}" [
                (gvariant.mkDictionaryEntry [
                  "location"
                  loc
                ])
              ]
            ) worldClocks
          );
          "org/gnome/desktop/interface" = {
            accent-color = "teal";
            clock-show-weekday = true;
            color-scheme = "prefer-dark";
          };
          "org/gnome/desktop/peripherals/keyboard".numlock-state = true;
          "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
          "org/gnome/desktop/screensaver".lock-enabled = false;
          "org/gnome/desktop/wm/preferences".resize-with-right-button = true;
          "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-timeout = 1800;
          "org/gnome/shell" = {
            enabled-extensions = map (ext: ext.extensionUuid) extensions;
            favorite-apps = [
              "org.gnome.Nautilus.desktop"
              "firefox.desktop"
              "com.mitchellh.ghostty.desktop"
              "codium.desktop"
              "dbeaver.desktop"
              "bruno.desktop"
              "teams-for-linux.desktop"
              "discord.desktop"
              "spotify.desktop"
              "steam.desktop"
            ];
          };
          "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;
          "org/gnome/shell/extensions/caffeine".show-notifications = false;
          "org/gnome/shell/weather".automatic-location = true;
          "org/gnome/shell/world-clocks".locations = gvariant.mkArray "v" worldClocks;
          "org/gnome/system/location".enabled = true;
          "org/gtk/gtk4/settings/file-chooser".show-hidden = true;
        };
      };
    };
}
