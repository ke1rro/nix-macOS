{
  description = "Ke1rro system setup with nix-darwin & home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin.url = "github:lnl7/nix-darwin";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }:
    let
      system = "aarch64-darwin";
      username = "nikitalenyk";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      darwinConfigurations."MacBook-Pro-Nikita" = darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./darwin/configuration.nix
        ];
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home/home.nix
        ];
      };
    };
}
