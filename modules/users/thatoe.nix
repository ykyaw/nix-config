{ inputs, ... }: {
  flake.modules.nixos.nixos-desktop = { config, pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users = {
      mutableUsers = false;
      users.thatoe = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.user-password.path;
        shell = pkgs.fish;
        extraGroups = [ "wheel" ];
      };
    };

    programs.fish.enable = true;

    security.sudo.configFile = ''
      Defaults insults
      Defaults lecture=never
    '';

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.thatoe.imports = with inputs.self.modules.homeManager; [
        workstation
        nixos-desktop
      ];
    };
  };
}
