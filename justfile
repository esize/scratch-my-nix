b:
    sudo nixos-rebuild switch --flake .#tutorial
    home-manager switch --flake .


update:
    nix flake update .

alias u := update

new-profile name:
    mkdir profiles/{{name}}
    cp templates/profile/configuration.nix profiles/{{name}}
    cp templates/profile/home.nix profiles/{{name}}
    touch profiles/{{name}}/README.md
    echo "# {{titlecase(name)}}" >> profiles/{{name}}/README.md
    git add profiles/{{name}}
    git commit -m "added new profile '{{name}}'"

alias np := new-profile

new-system-module name: