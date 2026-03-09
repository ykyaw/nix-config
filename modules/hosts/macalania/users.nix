{ config, inputs, ... }:
{
  flake.modules.darwin.macalania.imports = [ inputs.self.modules.darwin.${config.username} ];
}
