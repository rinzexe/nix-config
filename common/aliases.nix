{
  environment.shellAliases = {
    ll = "ls -l";
    rebuild = "sudo nixos-rebuild switch --flake /home/rinz/Config/nix-config/#default --impure --refresh";
    flake-cuda = "nix develop github:rinzexe/nix-flakes/cuda";
  };
}