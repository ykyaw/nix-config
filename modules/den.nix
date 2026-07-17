{ den, inputs, ... }: {
  flake-file.inputs.den.url = "github:denful/den";

  imports = [ (inputs.den.flakeModules.dendritic or { }) ];

  den.default = {
    includes = [
      den.batteries.hostname
      den.batteries.define-user
    ];

    nixos.system.stateVersion = "26.05";
  };
}
