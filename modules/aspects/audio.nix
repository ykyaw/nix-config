{
  flake.modules.nixos.workstation = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
