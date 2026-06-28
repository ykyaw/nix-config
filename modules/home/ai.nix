{
  flake.modules.homeManager.ai = { lib, pkgs, ... }: {
    allowedUnfreePackages = [ "claude-code" ];

    programs = {
      claude-code = {
        enable = true;
        enableMcpIntegration = true;
      };
      mcp = {
        enable = true;
        servers = {
          nixos = {
            command = lib.getExe pkgs.mcp-nixos;
            type = "stdio";
          };
        };
      };
    };
  };
}
