{ inputs, ... }:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "zanarkand";

  flake.modules.nixos.zanarkand = {
    imports = with inputs.self.modules.nixos; [
      base
      gnome
      gaming
    ];

    networking.hostName = "zanarkand";

    # Temporary workaround for system freezes.
    # https://bugzilla.kernel.org/show_bug.cgi?id=221103
    services.udev.extraRules = ''
      ACTION=="add|change", SUBSYSTEM=="pci", KERNEL=="0000:6c:00.4", ATTR{power/control}="on"
    '';
  };
}
