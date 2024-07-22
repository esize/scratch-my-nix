{config, pkgs, lib, ... }:
with lib; let

  cfg = config.options.user
in {
  options.user = {
    tools.git = {
      enable = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Set up git for the user
        ''
      }
    }
  };

  config = mkIf cfg.tools.git.enable {
    home.pkgs = [pkgs.git];

    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  }

}