{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "dnhpnfgdlenaccegplpojghhmaamnnfp"; } # Augmented Steam
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden - Free Password Manager
      { id = "bfogiafebfohielmmehodmfbbebbbpei"; } # Keeper® Password Manager & Digital Vault
      { id = "olagniaikhbmpdgghoifgloijcndfled"; } # Show Great on Deck on Steam
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube - Skip Sponsorships
      { id = "kdbmhfkmnlmbkgbabkdealhhbfhlmmon"; } # SteamDB
      { id = "lcbjdhceifofjlpecfpeimnnphbcjgnc"; } # xBrowserSync
    ];
  };
}
