{ inputs, ... }:
let
  name = "thatoe";
in
{
  flake.modules.nixos.home = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.${name} = {
      isNormalUser = true;
      initialHashedPassword = "$y$j9T$V4ACLsuBY7IPM1bvux.461$AvIIfkcqYm1PRi.ESSk.f61.gzxeIkBUZ7Uhurr7EgB";
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
