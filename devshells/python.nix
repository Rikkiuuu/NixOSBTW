{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    (python3.withPackages (ps: [ ps.pip ps.debugpy ]))
    ruff
    basedpyright
  ];
  # Virtual envs: python -m venv .venv
}
