{
  description =
    "A flake giving access to fonts that I use, outside of nixpkgs.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
      let 
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.${system}.departure-mono = pkgs.stdenv.mkDerivation {
          name = "departure-mono";
          dontConfigure = true;
          src = pkgs.fetchzip {
            url = 
              "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DepartureMono.zip";
            sha256 = "sha256-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
            stripRoot = false;
          };

          installPhase = ''
            mkdir -p $out/share/fonts
            cp -R $src $out/share/fonts/opentype
          '';
          meta = { description = "Departure Mono Nerd Font"; };
        };

                      defaultPackage.${system} = self.packages.${system}.departure-mono;

        devShells.${system}.default = pkgs.mkShell {
          packages = [ self.packages.${system}.departure-mono ];
        };
      };
}