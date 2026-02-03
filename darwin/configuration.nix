{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    git
    curl
    wget
    vim
    (python313.withPackages(ps: with ps; [pip]))
  ];

  nix.extraOptions = ''
    auto-optimise-store = true
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 2; Minute = 0; };
    options = "--delete-older-than 7d";
  };

  system.stateVersion = 6;
}
