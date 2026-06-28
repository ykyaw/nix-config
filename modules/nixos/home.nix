{ inputs, ... }:
let
  name = "thatoe";
in
{
  flake.modules.nixos.home = { config, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.${name} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.user-password.path;
      extraGroups = [ "wheel" ];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${name} = {
        imports = builtins.attrValues inputs.self.modules.homeManager;

        home = {
          username = name;
          homeDirectory = "/home/${name}";
          stateVersion = "26.05";
        };

        programs.home-manager.enable = true;
      };
    };
  };
}
