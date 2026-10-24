{
  description = "Raad System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05"; 
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";    
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, unstable, lanzaboote, ... }@inputs: 
  let
    system = "x86_64-linux";
    unstablePkgs = import unstable {
      inherit system;
      config.allowUnfree = true;
      config.android_sdk.accept_license = true;
    };
  in {
    nixosConfigurations = {
      raad = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit unstablePkgs; };
        modules = [
          ./hosts/raad/configuration.nix
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit unstablePkgs; };
            home-manager.users.sa7 = import ./modules/home.nix;
          }
        ];
      };
    };

    homeConfigurations = {
      "dev" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit unstablePkgs; };
        modules = [
          ./modules/ubuntu-dev-home.nix
#          ./modules/gnome.nix
          {
            home.username = "dev";
            home.homeDirectory = "/home/dev";
            home.stateVersion = "24.05"; 
          }
        ];
      };
    };
  };
}
