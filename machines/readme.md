# Machine Hardware Configuration

## Machine Bootstrap Instructions

The bootstrap configuration for homelab machines is as follows...
homelab/machines contains a directory for each machine...
```sh
# Directory Structure
/homelab/machine/lenovo
/homelab/machines/lenovo/disko.nix

/homelab/machines/flake.nix
```
TODO: Finsish documentation
---

### Common Machine Installation Process

[NixOS Wiki: Disko](wiki.nixos.org/wiki/Disko)

#### Enable ssh on NixOS Install image...
```sh
# Run ip addr to get the ip
ip addr
# Set the user's password
passwd
# Set the root user's password
sudo passwd
# Restart sshd
sudo systemctl restart sshd
```
#### Install the boostsrap image...
```sh
# This example will use the Lenovo machine configuration...
#
# 1.  Boot the machine/vm with the NixOS installer
# 2.  Retrieve the git repository

cd ~/
git clone https://github.com/briancprice/homelab.git

# 3.  Run Disko to partition/format the drives
# *** WARNING this is destructive!
sudo nix --experimental-features "nix-command flakes" \
run github:nix-community/disko -- \
--mode disko ./machines/lenovo/disko-config

# Notice that the command enables flakes and nix-command
# Look at all the output from disko and verify success

# 4.  Install the simple onboarding configuration for the        machine...

sudo nix-install --flakes ./machines#lenovo-bootstrap \
--no-root-passwd

# 5.  Reboot the machine and verify success.  The bootstrap profiles only have one user by default, this is root, you'll need to ssh into the machine using the key

# 6.  Perform any imparative configuration needed for the machine
#     - SOPS secrets for example

# 7.  Run the installer for the main machine host
# Notice this flake is in the homelab root directory
nixos-install --flakes ./#lenovo-host \
--no-root-passwd

```

---
*See the readme in the root of this project for more information.*