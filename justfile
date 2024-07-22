b:
    sudo nixos-rebuild switch --flake .#tutorial
    home-manager switch --flake .


update:
    nix flake update .

alias u := update

new-profile name description:
    mkdir profiles/{{name}}
    cp templates/profile/configuration.nix profiles/{{name}}
    touch profiles/{{name}}/README.md
    echo "# {{titlecase(name)}}" >> profiles/{{name}}/README.md
    echo "{{description}}" >> profiles/{{name}}/README.md
    echo "- [{{titlecase(name)}}](./{{name}}) - {{description}}" >> profiles/README.md
    git add profiles/{{name}}
    git commit -m "added new profile '{{name}}'"

alias np := new-profile

new-system-module name description:
    mkdir system/{{name}}
    cp templates/systemModule/default.nix system/{{name}}
    touch system/{{name}}/README.md
    echo "# {{titlecase(name)}}" >> system/{{name}}/README.md
    echo "{{description}}" >> system/{{name}}/README.md
    echo -e "\n- [{{titlecase(name)}}](./{{name}}) - {{description}}" >> system/README.md
    git add system/{{name}}
    git add system/README.md
    git commit -m "added new system module '{{name}}'"

alias ns := new-system-module