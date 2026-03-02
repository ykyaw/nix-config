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
  };
}
