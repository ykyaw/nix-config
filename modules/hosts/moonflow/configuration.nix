{ inputs, ... }:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "moonflow";

  flake.modules.nixos.moonflow = {
    imports = with inputs.self.modules.nixos; [
      base
      gnome
      gaming
    ];

    networking.hostName = "moonflow";
  };
}
