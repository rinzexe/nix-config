{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
                ({ ... }: {
          nixpkgs.config.permittedInsecurePackages = [
            "dotnet-sdk-6.0.428"
            "dotnet-runtime-6.0.36"
          ];
        })
        ./common/aliases.nix
        ./common/config.nix
        /etc/nixos/configuration.nix
      ];
    };
  };
}