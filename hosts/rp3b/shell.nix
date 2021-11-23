{ pkgs ? import <nixos-stable> { } }:
pkgs.mkShell {
  nixPath = "nixpkgs=https://nixos.org/channels/nixos-21.05/nixexprs.tar.xz";
  nativeBuildInputs = [
    pkgs.nixops
  ];
}
