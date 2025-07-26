{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 #   stylix = {
 #     url = "github:danth/stylix";
 #     inputs.nixpkgs.follows = "nixpkgs";
 #   };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass arguments to NixOS and home-manager modules
      specialArgs = {
        inherit inputs; # Makes inputs (like home-manager) available to modules
      };

      modules = [
        ./system/configuration.nix # <-- Main entry point
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        inputs.catppuccin.nixosModules.catppuccin
 #       inputs.stylix.nixosModules.stylix
        inputs.spicetify-nix.nixosModules.spicetify
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # home.nix file used for user "bod"
          home-manager.users.bod = {
            imports = [
              ./home/home.nix
              inputs.catppuccin.homeModules.catppuccin
            ];
          };
        }
      ];
    };
  };
}
