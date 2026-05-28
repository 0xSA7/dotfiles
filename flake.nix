{
  description = "Raad System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; 
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";    
    
    # Home Manager integration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, unstable, ... }@inputs: 
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
  };
}
