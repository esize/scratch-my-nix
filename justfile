b:
    sudo nixos-rebuild switch --flake .#tutorial
    home-manager switch --flake .

new-profile name:
    mkdir profiles/{{name}}
    touch profiles/{{name}}/configuration.nix
    touch profiles/{{name}}/home.nix
    touch profiles/{{name}}/README.md
    git add profiles/{{name}}
    git commit -m "added new profile '{{name}}'"

