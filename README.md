# etc-public
common configs wot i don't mind making world-readable

-----


- mkdir /etc/shm/$VRBO_ROOT
- git clone this into there
- run vrbo_cfg_env 
- run other stuff


- /run/user/$uid might be a better source for this (or /tmp

# 2022-07-28
- fzf + Vim seems to work fine on test env


# 2022-07-19
- so: 
    - > make a dir on /dev/shm
    - > download junk to it
    - > source an entrypoint (direnv?)
    - ...
    - > nix? 
    - > profit!

