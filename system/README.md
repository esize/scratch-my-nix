# System-level Nix Modules
Separate Nix files can be imported as modules using an import block:

```nix
imports = [ import1.nix
            import2.nix
            ...
          ];
```

## Variables imported from flake.nix

Variables can be imported from [flake.nix](../flake.nix) by setting the `specialArgs` block inside the flake (see my [flake](../flake.nix) for more details). This allows variables to merely be managed in one place ([flake.nix](../flake.nix)) rather than having to manage them in multiple locations.

I use this to pass a few attribute sets:

`userSettings` - Settings for the normal user (see [flake.nix](../flake.nix) for more details)
`systemSettings` - Settings for the system (see [flake.nix](../flake.nix) for more details)
`inputs` - Flake inputs (see [flake.nix](../flake.nix) for more details)
`pkgs-stable` - Allows me to include stable versions of packages along with (my default) unstable versions of packages


My system-level Nix modules are organized into this directory:

- [App](./{app}) - Necessary system-level config to get apps working
