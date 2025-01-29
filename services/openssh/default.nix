{ config, lib, namespace, ... }: 
let
  cfg = config.${namespace}.homelab.services.openssh;
in
with lib; {
  options.${namespace}.homelab.services.openssh = {
    enable = mkEnableOption {
      default = false;
    };

    mode = mkOption {
      type = types.enum [ "permissive" "secure" ];
      default = "secure";
      description = 
        ''
        ***permissive***:   Root login is enabled, password authentication is enabled.
        ***secure***:       Root login is prohibit-password, password authentication is disabled.
        '';
    };

    authorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [ 
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQM3PinzEcWHWb7JZ+5iJMttHhlbIizZ4T9bcXvCD3f"
        ];
    };

    opensshUserName = mkOption {
      type = types.str;
      default = "root";
    };

  };

  config = mkIf cfg.enable {
    services.openssh.enable = true;
    services.openssh.settings.PermitRootLogin = if cfg.mode == "permissive" then "yes" else "prohibit-password";
    services.openssh.settings.PasswordAuthentication = if cfg.mode == "permissive" then true else false;
    users.users.${cfg.opensshUserName}.openssh.authorizedKeys.keys = mkIf (count cfg.authorizedKeys != 0) cfg.authorizedKeys;
  };
}