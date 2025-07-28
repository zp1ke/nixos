{
  description = "NixOS configuration with flakes and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur-comfy = {
      url = "github:gvolpe/nur-comfy";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, nur-comfy, ... }@inputs:
    let
      system = "x86_64-linux";
      hostname = "legion";
      username = "zp1ke";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          # Hardware configuration
          ./hosts/${hostname}/hardware-configuration.nix

          # System configuration
          ./hosts/${hostname}/configuration.nix

          # Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${username}" = import ./home-manager/${username}.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              nur-comfy = nur-comfy.packages.${system};
            };
          }
        ];
      };
    };
}