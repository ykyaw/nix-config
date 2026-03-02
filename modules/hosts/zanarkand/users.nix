{ config, inputs, ... }:
{
  flake.modules.nixos.zanarkand = {
    imports = [ inputs.self.modules.nixos.${config.username} ];

    users.mutableUsers = false;
  };
}
