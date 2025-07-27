{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    openfortivpn
    networkmanager-fortisslvpn  # NetworkManager plugin for FortiSSL VPN
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

  # VPN connection scripts using external script files
  home.packages = [
    # VPN connection script
    (pkgs.writeShellScriptBin "vpn-connect" (builtins.readFile ./scripts/vpn_connect.sh))

    # VPN disconnection script
    (pkgs.writeShellScriptBin "vpn-disconnect" (builtins.readFile ./scripts/vpn_disconnect.sh))

    # VPN status script
    (pkgs.writeShellScriptBin "vpn-status" (builtins.readFile ./scripts/vpn_status.sh))

    # VPN setup script
    (pkgs.writeShellScriptBin "vpn-setup" (builtins.readFile ./scripts/vpn_setup.sh))
  ];
}
