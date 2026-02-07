# nix-config

NixOS configuration with flakes, home-manager, impermanence, and secure boot.

## Structure

```
flake.nix               # Flake entry point
vars.nix                # Centralized variables
.sops.yaml              # Sops creation rules & age keys

hosts/
  zanarkand/            # Desktop
modules/
  nixos/                # NixOS modules
  home/                 # Home-manager modules
secrets/
  secrets.yaml          # Encrypted secrets
```
