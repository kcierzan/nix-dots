#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/kylec/home.nix
popd
