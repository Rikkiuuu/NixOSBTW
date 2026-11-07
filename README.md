# My nixOS CONFIG

## Setup
    cp -r <this folder> ~/nixos && cd ~/nixos
    cp /etc/nixos/hardware-configuration.nix .   
    git init && git add -A                      
    nix flake check                              
    #   nix --extra-experimental-features 'nix-command flakes' flake check

## Apply (two separate configs)
    sudo nixos-rebuild switch --flake ~/nixos#hostname    
    nix run home-manager/release-26.05 -- switch --flake ~/nixos#username  
    home-manager switch --flake ~/nixos#username            

After editing any file (including dotfiles): `git add -A`, then re-run the relevant switch.

## Dev shells
    nix develop ~/nixos#go     # or #c  #rust  #python

## Update
    nix flake update                    
    nix flake update nixpkgs              
    nix flake update nixpkgs-unstable   
    nix flake update home-manager          


## Roll back / clean
    sudo nixos-rebuild switch --rollback  
    home-manager generations              
    sudo nix-collect-garbage --delete-older-than 14d
    nix-collect-garbage --delete-older-than 14d
