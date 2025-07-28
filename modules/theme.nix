{ config, pkgs, nur-comfy, ... }:

{
  imports = [ nur-comfy.homeManagerModules.default ];

  # Yin-Yang: Automatic Light/Dark Theme Switching
  services.yin-yang = {
    enable = true;
    # Set the times for light and dark modes.
    # You can also use latitude and longitude for sunrise/sunset.
    settings = {
      followSun = false; # To use sunrise/sunset
      # latitude = 40.71;  # Example: New York City
      # longitude = -74.00; # Example: New York City

      # If not following sun, use these fixed times
      times = [ "06:30" "18:30" ];

      # Specify which themes to use
      themes = {
        # KDE Plasma Global Theme
        plasma = [ "Breeze" "Breeze-Dark" ];
        # GTK Theme (for apps like GIMP, Inkscape)
        gtk = [ "Breeze" "Breeze-Dark" ];
        # VS Code Theme
        code = [ "Default Light+" "Default Dark+" ];
        # Konsole Color Scheme
        konsole = [ "WhiteOnBlack" "Breeze" ];
      };
    };
  };

  home.packages = with pkgs; [
    kdePackages.breeze
  ];
}
