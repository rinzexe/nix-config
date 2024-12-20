{
  environment.shellAliases = {
    ll = "ls -l";
    rebuild = "sudo nixos-rebuild switch --flake github:rinzexe/nix-config#default --impure";
    flake-cuda = "nix develop github:rinzexe/nix-flakes/cuda";
  };
}