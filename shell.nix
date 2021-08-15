{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  basePackages = [
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-language-server
    elmPackages.elm-review
    elmPackages.elm-test
    nixfmt
    nodejs
    yarn
  ];

  inputs = basePackages;

  hooks = ''
    mkdir -p .nix-elm
    export ELM_HOME=$PWD/.nix-elm
  '';
in mkShell {
  buildInputs = inputs;
  shellHook = hooks;
}
