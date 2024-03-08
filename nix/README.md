

# Notes
## 2024-02-29 

Install into namespace/chroot

```

# get nix-user-chroot
wget https://github.com/nix-community/nix-user-chroot/releases/download/1.2.2/nix-user-chroot-bin-1.2.2-x86_64-unknown-linux-musl -O ~/bin/nix-user-chroot
chmod +x ~/bin/nix-user-chroot

# install nix into chroot
mkdir -m 0755 ~/.nix
nix-user-chroot ~/.nix bash -c 'curl -L https://nixos.org/nix/install | sh'

# start shell in chroot
nix-user-chroot ~/.nix bash

# and source env 
source ~/.nix-profile/etc/profile.d/nix.sh

```


## 2024-01-18 


```

NIX_BIN=~/bin/nix-portable

mkdir -p ~/bin 
wget https://github.com/DavHau/nix-portable/releases/download/v010/nix-portable -O $NIX_BIN
chmod +x $NIX_BIN
$NIX_BIN nix-shell devenv-smol.nix

# takes ~1 min to pull ~1G packages;  (c|sh)ould optimize this w/ busybox/musl

```

