# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  config,
  lib,
  userSettings,
  pkgs,
  ...
}:
with lib; let
  cfg.sys = config.system;
  cfg.usr = config.user;
in {
  options.system = {
    arch = mkOption {
      name = "Architecture";
      description = "System architecture type";
      default = "x86_64-linux";
      example = "x86_64-linux";
      type = types.enum ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
    };
    wsl = mkEnableOption "WSL";
    hostname = mkOption {
      name = "Hostname";
      description = "System hostname";
      default = "nixos";
      type = types.str;
    };
    timezone = mkOption {
      name = "Timezone";
      description = "Select system timezone";
      default = "America/New_York";
      example = "America/New_York";
      type = types.str;
    };
    locale = mkOption {
      name = "Locale";
      description = "Select system locale";
      default = "en_US.UTF-8";
      example = "en_US.UTF-8";
      type = types.str;
    };
    bootMode = mkOption {
      name = "Boot Mode";
      description = "System architecture type";
      default = "uefi";
      example = "uefi";
      type = types.enum ["uefi" "bios"];
    };
    bootMountPath = mkOption {
      name = "Boot Mount Path";
      description = "Mount path for efi boot partition; only used for uefi boot mode";
      default = /boot;
      example = /boot;
      type = types.path;
    };
    grubDevice = mkOption {
      name = "GRUB Device";
      description = "Device identifier for grub; only used for legacy (bios) boot mode";
      default = "";
      type = types.str;
    };
    gpuType = mkOption {
      name = "GPU Type";
      description = "Makes some slight modifications for GPU type";
      default = "amd";
      example = "amd";
      type = types.enum ["amd" "intel" "nvidia"];
    };
    defaultShell = mkOption {
      name = "Default Shell";
      description = "Default login shell";
      default = "zsh";
      example = "bash";
      type = types.enum ["bash" "zsh" "fish"];
    };
    shells = {
      bash.enable = mkEnableOption "Enable Bash";
      zsh.enable = mkEnableOption "Enable ZSH";
      fish.enable = mkEnableOption "Enable Fish";
    };
  };
  config = {
    # Ensure nix flakes are enabled
    nix.package = pkgs.nixFlakes;
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';

    nixpkgs.config.allowUnfree = true;

    # User account
    users.users.${cfg.usr.username} = {
      isNormalUser = true;
      description = cfg.usr.name;
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [];
      uid = 1000;
    };

    environment.systemPackages = with pkgs; [
      wget
      neovim
      git
      nixd
      just
    ];

    # Necessary for VSCode Remote-SSH
    programs.nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

    system.stateVersion = "24.05"; # DO NOT CHANGE
  };
}
