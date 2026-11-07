{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    go
    gopls
    delve
    git
    gnumake
  ];
  hardeningDisable = [ "fortify" ]; # required for delve
}
