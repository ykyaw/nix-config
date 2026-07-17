{ den, ... }: {
  den.aspects.thatoe.includes = [ den.aspects.ai ];

  den.aspects.ai = {
    includes = [ (den.batteries.unfree [ "claude-code" ]) ];

    homeManager = { lib, pkgs, ... }: {
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
  };
}
