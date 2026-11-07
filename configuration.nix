{ config, lib, pkgs, pkgs-unstable, hostname, username, ... }:

{
  imports = [ ./hardware-configuration.nix ];


  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "26.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-media-driver ]; # VA-API (iHD) for Gen 9+ incl. Skylake
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1"; # Electron/Chromium apps use Wayland
  };

  zramSwap.enable = true;


  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };


  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };


  time.timeZone = "Region/City";
  i18n.defaultLocale = "en_US.UTF-8";


  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "plasma"; #

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
    krdp
  ];

  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
  };
  programs.niri.enable = true;

  programs.dconf.enable = true;


  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts # includes Noto Sans
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };


  programs.zsh.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
  ];
}
