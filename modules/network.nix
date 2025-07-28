{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    openfortivpn
    networkmanager-fortisslvpn  # NetworkManager plugin for FortiSSL VPN

    # VPN connection scripts
    (writeShellScriptBin "vpn-connect" (builtins.readFile ./scripts/vpn_connect.sh))
    (writeShellScriptBin "vpn-disconnect" (builtins.readFile ./scripts/vpn_disconnect.sh))
    (writeShellScriptBin "vpn-status" (builtins.readFile ./scripts/vpn_status.sh))
    (writeShellScriptBin "vpn-setup" (builtins.readFile ./scripts/vpn_setup.sh))
  ];

  # VPN configuration files
  home.file.".config/openfortivpn/config" = {
    text = ''
      # Default openfortivpn configuration
      # host = vpn.company.com
      # port = 443
      # username = your_username
      # password = your_password
      # trusted-cert = <certificate_fingerprint>

      # Security options
      set-routes = 1
      set-dns = 1
      pppd-use-peerdns = 1

      # Connection options
      # realm = your_realm
      # user-cert = /path/to/client.crt
      # user-key = /path/to/client.key
      # ca-file = /path/to/ca.crt
    '';
  };
}
