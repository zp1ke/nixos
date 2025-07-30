{ config, pkgs, ... }:

{
  # Enable sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable CUPS for printing
  services.printing.enable = true;

  # Common programs
  programs.zsh.enable = true;
  programs.git.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    cascadia-code
    fira-code
    font-awesome
    inter
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    powerline-fonts
  ];
  fonts.fontconfig.enable = true;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ]; # SSH
  };
}
