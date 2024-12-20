{
  environment.shellAliases = {
    ll = "ls -l";
    rebuild = "sudo nixos-rebuild switch --flake github:rinzexe/nix-config#default --impure --no-write-lock-file --refresh";
    flake-cuda = "nix develop github:rinzexe/nix-flakes/cuda";
  };
}