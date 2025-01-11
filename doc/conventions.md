
## Security:

### Imparative Processes
- **DO NOT**: Try to make *everything* imparative, even though it's tempting.  NixOS files are checked into source control which can be dangerous

### Secrets
- **DO**: Use [sops](https://github.com/mic92/sops-nix) for secrets
- **DO**: Check non-critical sops-encrypted secrets into github
  - **DO NOT**: Use the github ssh key for the sops key
  - **DO NOT**: Check external (from the homelab) service keys into github, even encrypted ones.

 **DO**: Configure external access keys imparatively, for example...
  - **DO**: Generate a github key for each machine that needs one (the old fashioned way)
  - **DO**: Store *critical* secrets inside a third-party-secrets manager
    - api keys
    - passwords to external sites (even trivial iot ones)
- **DO**: Be cautious of packages that could become dangerous.
  - **DO**: Inspect the source.
  - **CONSIDER** Reference a specific github hash.
- **CONSIDER**: Store critical keys in manually generated sops files that are not checked into version control.  These files will be held in the NixOS store, but they will reamin encrypted and will only be local.
- **DO**: Use a separate sops file for every category of secrets, for example; for each service.

## General Guidelines and Tips

### Optimization
- **DO**: Create a NixOS build machine
- **DO**: Create a local NixOS binary cache
  - Hosting this cache must be ***expensive***


