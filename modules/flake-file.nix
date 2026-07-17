{ inputs, ... }: {
  flake-file.inputs = {
    flake-file.url = "github:denful/flake-file";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  imports = [ (inputs.flake-file.flakeModules.dendritic or { }) ];
}
