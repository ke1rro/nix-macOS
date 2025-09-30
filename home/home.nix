{ config, pkgs, ... }:

let
  myJDK = pkgs.zulu21;
in


{
  home.username = "nikitalenyk";
  home.homeDirectory = pkgs.lib.mkForce "/Users/nikitalenyk";

  home.packages = with pkgs; [
    wezterm
    zoxide
    starship
    bat
    fd
    ripgrep
    (logisim-evolution.override {
      jre = myJDK;
    })
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

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
