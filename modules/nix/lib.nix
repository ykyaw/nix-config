{ inputs, lib, ... }:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = {
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ inputs.self.modules.nixos.${name} ];
      };
    };
  };
}
