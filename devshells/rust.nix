{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy
  ];
  RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
}
