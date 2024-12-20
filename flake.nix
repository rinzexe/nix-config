{
  description = "NIXOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # fixes a weird bug, don't remove
                ({ ... }: {
          nixpkgs.config.permittedInsecurePackages = [
            "dotnet-sdk-6.0.428"
            "dotnet-runtime-6.0.36"
          ];
        })
        ./common/aliases.nix
        ./common/config.nix
        ./pc/configuration.nix
      ];
    };
  };
}