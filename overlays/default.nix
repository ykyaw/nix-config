{ inputs, ... }:

{
  modifications = final: prev: {
    steam = prev.steam.overrideAttrs (old:
      let
        inherit (builtins) concatStringsSep attrValues mapAttrs;
        inherit (final) stdenv stdenv_32bit runCommandWith runCommandLocal makeWrapper;

        platforms = {
          haswell = 64;
          i686 = 32;
        };

        preloadLibFor = bits: assert bits == 64 || bits == 32;
          runCommandWith
            {
              stdenv = if bits == 64 then stdenv else stdenv_32bit;
              runLocal = false;
              name = "sdl-fix-steam-screensaver.${toString bits}bit.so";
              derivationArgs = { };
            } "gcc -shared -fPIC -ldl -m${toString bits} -o $out ${./sdl-fix-steam-screensaver.c}";

        preloadLibs = runCommandLocal "sdl-fix-steam-screensaver" { } (concatStringsSep "\n" (attrValues (mapAttrs
          (platform: bits: ''
            mkdir -p $out/${platform}
            ln -s ${preloadLibFor bits} $out/${platform}/sdl-fix-steam-screensaver.so
          '')
          platforms)));
      in
      {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ makeWrapper ];
        buildCommand = (old.buildCommand or "") + ''
          steamBin="$(readlink $out/bin/steam)"
          rm $out/bin/steam
          makeWrapper $steamBin $out/bin/steam --prefix LD_PRELOAD : ${preloadLibs}/\$PLATFORM/sdl-fix-steam-screensaver.so
        '';
      }
    );
  };
}
