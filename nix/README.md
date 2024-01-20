

# Notes
## 2024-01-18 


```

NIX_BIN=~/bin/nix-portable

mkdir -p ~/bin 
wget https://github.com/DavHau/nix-portable/releases/download/v010/nix-portable -O $NIX_BIN
chmod +x $NIX_BIN
$NIX_BIN nix-shell devenv-smol.nix

# takes ~1 min to pull ~1G packages;  (c|sh)ould optimize this w/ busybox/musl

```

