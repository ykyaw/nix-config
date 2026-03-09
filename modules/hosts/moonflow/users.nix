{ config, inputs, ... }:
{
  flake.modules.nixos.moonflow = {
    imports = [ inputs.self.modules.nixos.${config.username} ];

    users.mutableUsers = false;
  };
}
