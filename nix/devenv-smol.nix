{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    tmux
    ripgrep
    wget
    curl
    bat
    gopass
    zip
    unzip
    lnav
  ];

  shellHook = ''
    echo "node version: $(node -v)"
    echo "python version: $(python3 --version)"
  '';

}

