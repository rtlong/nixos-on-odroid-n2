{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }@inputs:
    rec {
      sdImageSystem = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./sd-image.nix ];
      };

      sdImage = sdImageSystem.config.system.build.sdImage;

      nixosConfigurations = {
        odroid = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [ ./machines/optiplex ];
        };
      };
    };

}
