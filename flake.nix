{
  description = "System Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = { url = "github:nix-community/home-manager"; };
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { nixpkgs, home-manager, ... } : 
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        zephyrus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/configuration.nix ];
        };
      };

      homeConfigurations = {
        "gts@zephyrus" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home.nix ];
        };
      };
    };
}
