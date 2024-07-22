{config, pkgs, ...}@inputs: {
  imports = [./tmux/default.nix ./neovim/default.nix ./git/default.conf ./files/default.conf]

  home.packages = with pkgs; [
    eza
    zoxide
    fd
    bottom
    ripgrep
    fzf
    bat
    numbat
  ];
}