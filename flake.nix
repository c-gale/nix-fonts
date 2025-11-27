{
  description =
    "A flake giving access to fonts that I use, outside of nixpkgs.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        defaultPackage = pkgs.symlinkJoin {
          name = "myfonts-0.0.1";
          paths = builtins.attrValues
            self.packages.${system}; # Add font derivation names here
        };

        packages.departure-mono = pkgs.symlinkJoin {
          name = "departure-mono";
          dontConfigure = true;
          src = pkgs.fetchzip {
            url = 
              "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DepartureMono.zip";
            sha256 = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
            stripRoot = false;
          };

          installPhase = ''
            mkdir -p $out/share/fonts
            cp -R $src $out/share/fonts/opentype
          '';
          meta = { description = "Departure Mono Nerd Font"; };
        };
      });
}