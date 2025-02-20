{
  description = "A very simple flakes for development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsStable.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";
      legacy = "legacyPackages";
      pkgs = nixpkgs.${legacy}.${system};
      pkgsStable = inputs.nixpkgsStable.${legacy}.${system};
    in {
      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nodejs_18

          ];
          # shellHook = ''
          #   exec /bin/zsh
          # '';
        };
      };
    };
}
