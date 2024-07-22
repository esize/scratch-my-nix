# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{...}: let
  cfg.sys = config.system;
  cfg.usr = config.user;
in {
  imports = [
    ../../system/default.nix
    ../../user/default.nix
  ];
  wsl.enable = true;
  wsl.defaultUser = "evan";
}
