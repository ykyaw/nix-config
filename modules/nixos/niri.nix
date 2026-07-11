{ config, ... }:
let
  user = config.username;
in
{
  flake.modules.nixos.niri = { config, pkgs, ... }: {
    programs = {
      dconf.enable = true;
      niri.enable = true;
    };

    services = {
      gnome.gnome-keyring.enable = true;
      greetd = {
        enable = true;
        settings =
          let
            niriCommand = "${config.programs.niri.package}/bin/niri-session";
          in
          {
            initial_session = {
              command = niriCommand;
              inherit user;
            };
            default_session = {
              command = "${pkgs.greetd}/bin/agreety --cmd ${niriCommand}";
              user = "greeter";
            };
          };
      };
    };

    security.pam.services.greetd.rules.session.fdeBootPassword = {
      order = config.security.pam.services.greetd.rules.session.gnome_keyring.order - 10;
      control = "optional";
      modulePath = "${pkgs.pam_fde_boot_pw}/lib/security/pam_fde_boot_pw.so";
      settings.inject_for = "gkr";
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
