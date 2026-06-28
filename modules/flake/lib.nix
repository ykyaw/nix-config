{ inputs, lib, ... }: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = {
    mkNixos = name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ inputs.self.modules.nixos.${name} ];
      };
    };
  };
}
