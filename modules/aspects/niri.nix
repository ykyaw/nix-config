{
  flake.modules.nixos.nixos-desktop = { config, pkgs, ... }: {
    programs.niri.enable = true;

    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
      systemPackages = with pkgs; [
        nautilus
        xwayland-satellite
      ];
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
              user = "thatoe";
            };
            default_session = {
              command = "${pkgs.greetd}/bin/agreety --cmd ${niriCommand}";
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
  };
}
