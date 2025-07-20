{ pkgs, ... }:

{
  services = {
    postgresql.enable = true;
    redis = {
      enable = true;
      package = pkgs.valkey;
    };
  };
}
