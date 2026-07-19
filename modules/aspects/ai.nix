{
  allowedUnfreePackages = [ "claude-code" ];

  flake.modules.homeManager.workstation = { lib, pkgs, ... }: {
    programs = {
      claude-code = {
        enable = true;
        enableMcpIntegration = true;
      };
      mcp = {
        enable = true;
        servers.nixos = {
          command = lib.getExe pkgs.mcp-nixos;
          type = "stdio";
        };
      };
    };
  };
}
