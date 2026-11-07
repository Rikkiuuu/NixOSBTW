{
  description = "My personal NixOS setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      # >>> EDIT THESE TWO <<<
      hostname = "hostname";
      username = "username";

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {

      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit pkgs-unstable hostname username; };
        modules = [ ./configuration.nix ];
      };


      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit pkgs-unstable username; };
        modules = [ ./home-manager/home.nix ];
      };


      devShells.${system} = {
        go = import ./devshells/go.nix { pkgs = pkgs-unstable; };
        c = import ./devshells/c.nix { pkgs = pkgs-unstable; };
        rust = import ./devshells/rust.nix { pkgs = pkgs-unstable; };
        python = import ./devshells/python.nix { pkgs = pkgs-unstable; };
      };
    };
}
