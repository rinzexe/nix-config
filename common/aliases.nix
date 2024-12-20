{
  environment.shellAliases = {
    ll = "ls -l";
    rebuild = "sudo nixos-rebuild switch --flake github:rinzexe/nix-config#default --no-write-lock-file";
    flake-cuda = "nix develop github:rinzexe/nix-flakes/cuda";
  };
}