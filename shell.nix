{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/fc40ef0043a219f9.tar.gz") {},
}:

pkgs.mkShell {
  packages = [
    pkgs.godot
  ];
}
