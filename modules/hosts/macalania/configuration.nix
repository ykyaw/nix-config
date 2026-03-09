{ inputs, ... }:
{
  flake.darwinConfigurations = inputs.self.lib.mkDarwin "aarch64-darwin" "macalania";

  flake.modules.darwin.macalania = {
    imports = with inputs.self.modules.darwin; [ base ];

    networking.hostName = "macalania";
  };
}
