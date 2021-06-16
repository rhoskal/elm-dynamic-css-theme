{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  inherit (lib) optional optionals;

  basePackages = [
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-language-server
    elmPackages.elm-test
    nodejs
    yarn
  ];

  inputs = basePackages;
in

mkShell {
  buildInputs = inputs;
}

