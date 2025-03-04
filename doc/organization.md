# NixOS Configuration Organization


## Directory Structure

### services
The *services* folder contains the configuration for nixos level services
- There should be a folder for each folder, for example *ssh*
- When appropriate, there should be a nixos module for the service and the client
- Use sops for service secrets
- Do not check critical service data into github.

### users
The users folder contains per-user nixos configuration.
The configuration for dot files using [home-manager](https://github.com/nix-community/home-manager) goes here as well.
- Human users 
  - Go inside the *users* folder.
  - There is a folder for each user
  - The home-manager files go in the /users/<user> folder as well
  - Use [sops] to store the user password.
- System users
  - Defined with the service that needs them



  