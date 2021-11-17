{ pkgs ? import <nixos-stable> { } }:
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.nixops
  ];
}
