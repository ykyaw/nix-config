{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions =
      [
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden Password Manager
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube - Skip Sponsorships
      ]
      ++ (
        if pkgs.stdenv.isLinux then
          [
            { id = "dnhpnfgdlenaccegplpojghhmaamnnfp"; } # Augmented Steam
            { id = "ngonfifpkpeefnhelnfdkficaiihklid"; } # ProtonDB for Steam
            { id = "kdbmhfkmnlmbkgbabkdealhhbfhlmmon"; } # SteamDB
            { id = "lcbjdhceifofjlpecfpeimnnphbcjgnc"; } # xBrowserSync
          ]
        else
          [ ]
      );
  };
}
