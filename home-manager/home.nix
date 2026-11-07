{ config, pkgs, pkgs-unstable, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;


  home.packages =
    (with pkgs; [
      # CLI essentials
      fastfetch
      ripgrep
      fd
      jq
      tree
      unzip
      waybar
      rofi
      mako
      swaybg
      grim
      slurp
      wl-clipboard
      xwayland-satellite
    ])
    ++ (with pkgs-unstable; [
      kitty
      zed-editor
    ]);

  programs.git = {
    enable = true;
    settings = {
      user.name = "Your Name"; # REPLACE
      user.email = "you@example.com"; # REPLACE
      init.defaultBranch = "main";
    };
  };


  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };

  programs.librewolf = {
    enable = true;
    package = pkgs-unstable.librewolf;
  };
  programs.zsh.enable = true;

  xdg.configFile."kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
  xdg.configFile."hypr/hyprland.lua".source = ./dotfiles/hypr/hyprland.lua;
  xdg.configFile."niri/config.kdl".source = ./dotfiles/niri/config.kdl;
  xdg.configFile."waybar/config.jsonc".source = ./dotfiles/waybar/config.jsonc;
  # Add more the same way, e.g.:
  # xdg.configFile."mako/config".source = ./dotfiles/mako/config;
  # xdg.configFile."rofi/config.rasi".source = ./dotfiles/rofi/config.rasi;
}
