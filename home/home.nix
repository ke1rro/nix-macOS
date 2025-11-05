{ config, pkgs, ... }:

let
  myJDK = pkgs.zulu21;
in


{
  home.username = "nikitalenyk";
  home.homeDirectory = pkgs.lib.mkForce "/Users/nikitalenyk";

  home.packages = with pkgs; [
    eza
    wezterm
    zoxide
    starship
    bat
    fd
    ripgrep
    (logisim-evolution.override {
      jre = myJDK;
    })
    cmake
    llvm
    lldb
    gnumake
    pkg-config
    binutils
    coreutils
    file
    tmux
    tree
    procmap
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons";
    };

    initContent = ''
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"
    '';
  };

  programs.git = {
    enable = true;
    userName = "Nikita Lenyk";
    userEmail = "nikitalenyk2@gmail.com";
  };

  home.stateVersion = "24.11";
}
