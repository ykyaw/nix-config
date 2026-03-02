{ inputs, ... }:
{
  flake.modules.nixos.zanarkand = {
    imports = [ inputs.self.modules.nixos.thatoe ];

    users.mutableUsers = false;
  };
}
