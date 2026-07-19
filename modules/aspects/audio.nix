{
  flake.modules.nixos.nixos-desktop = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
