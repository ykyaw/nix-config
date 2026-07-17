{
  systems = [ "x86_64-linux" ];

  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShellNoCC {
      packages = with pkgs; [
        nixd
        nixfmt
        sbctl
        sops
      ];
    };
  };
}
