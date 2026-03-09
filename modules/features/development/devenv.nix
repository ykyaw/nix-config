{
  flake.modules.nixos.development = {
    nix.extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };

  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.devenv ];

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
