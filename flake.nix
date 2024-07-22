{
  description = "Evan's World";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    alejandra,
    nixos-wsl,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        inherit system;
        modules = [
          ./profiles/desktop/configuration.nix
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
        ];
      };
      laptop = lib.nixosSystem {
        inherit system;
        modules = [
          ./profiles/laptop/configuration.nix
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
        ];
      };
      server = lib.nixosSystem {
        inherit system;
        modules = [
          ./profiles/laptop/configuration.nix
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
        ];
      };
      wsl = lib.nixosSystem {
        inherit system;
        modules = [
          nixos-wsl.nixosModules.wsl
          ./profiles/wsl/configuration.nix
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
        ];
      };
    };
    homeConfigurations = {
      evan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./user/default.nix
        ];
      };
    };
  };
}
