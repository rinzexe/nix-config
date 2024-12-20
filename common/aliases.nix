# common/aliases.nix
{
  environment.shellAliases = {
    ll = "ls -l";
    rebuild = "sudo nixos-rebuild switch";
    flake-cuda = "nix develop github:rinzexe/nix-flakes/cuda"
  };
}