{config, pkgs, lib, ... }:
with lib; let

  cfg = config.options.user
in {
  options.user = {
    tools.neovim = {
      enable = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Set up neovim for the user
        ''
      }
    }
  };

  config = mkIf cfg.tools.neovim.enable {
    home.pkgs = [pkgs.neovim];

    
  }

}