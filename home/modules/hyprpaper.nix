{ config, pkgs, ... }:

let
  wallpaper = pkgs.fetchurl {
    url = "https://images3.alphacoders.com/134/1348349.png";
    sha256 = "07j4arhjrprwfpvkcd8865lb0s0li7w0mi7gps6lypfcvpnd4wkk";
  };
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload =
        [ "${wallpaper}" ];

      wallpaper = 
        [ ",${wallpaper}" ];
    };
  };
}
