{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
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
