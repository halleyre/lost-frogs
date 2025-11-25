{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/914a0a616adb4506.tar.gz") {},
}:

pkgs.mkShell {
  packages = [
    pkgs.godot
    pkgs.netcat
  ];
}
