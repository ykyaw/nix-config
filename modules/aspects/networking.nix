{
  flake.modules.nixos.nixos-desktop = {
    networking.networkmanager.enable = true;

    environment.persistence."/persist".directories = [
      {
        directory = "/etc/NetworkManager/system-connections";
        mode = "0700";
      }
    ];
  };
}
