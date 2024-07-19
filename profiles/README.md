# System Profiles
This directory contains various system profiles which can easily be set in my [flake.nix](../flake.nix) by setting the profile variable. Each profile directory contains a configuration.nix for system-level configuration and a home.nix for user-level configuration. Setting the profile variable in my [flake](../flake.nix) will automatically source the correct configuration.nix and home.nix.

Current profiles I have available are:

- [Desktop](./desktop/) - Full graphical install of NixOS
- [Laptop](./laptop/) - Pretty similar to desktop besides a few tweaks related to battery life and such
- [Server](./server/) - Base configuration for a server in my homelab. The only profile that allows access via ssh.
- [WSL](./wsl/) - System built for WSL.
