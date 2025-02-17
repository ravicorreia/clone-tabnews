{
  description = "Home Manager Setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsStable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      legacy = "legacyPackages";
      pkgs = nixpkgs.${legacy}.${system};
      pkgsStable = inputs.nixpkgsStable.${legacy}.${system};
    in {
      homeConfigurations = {
        ravicorreia = home-manager.lib.homeManagerConfiguration {
          inherit pkgs ;
          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./home.nix
          ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
          extraSpecialArgs = {
              inherit pkgsStable;  # it passes pkgsStable as an addional argument
          };
        };
      };
    };
}
