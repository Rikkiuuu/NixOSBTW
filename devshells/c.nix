{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    gcc
    gdb
    gnumake
    cmake
    ninja
    pkg-config
    clang-tools # clangd, clang-format, clang-tidy
  ];

  # Libraries your project links against go here so pkg-config finds them:
  # buildInputs = with pkgs; [ openssl zlib ];
}
