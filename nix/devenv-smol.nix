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
    fzf
    neovim
  ];

  shellHook = ''
    echo "node version: $(node -v)"
    echo "python version: $(python3 --version)"

    # enable fzf
    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
      source "$(fzf-share)/completion.bash"
    fi

  '';

}
