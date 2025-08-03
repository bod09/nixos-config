# /etc/nixos/system/modules/brightness.nix

{ config, pkgs, ... }:

let
  brightness-script = pkgs.writeShellScriptBin "brightness" ''
     #!/bin/sh
     backlight_dir="/sys/class/backlight/amdgpu_bl1"
     current_brightness=$(cat "$backlight_dir/brightness")
     max_brightness=$(cat "$backlight_dir/max_brightness")
     step=$((max_brightness / 20)) # 5% of max brightness
 
     if [ "$1" = "up" ]; then
       new_brightness=$((current_brightness + step))
     else
       new_brightness=$((current_brightness - step))

       # If the new value is zero or less, set it to 1 to keep the screen on.
       if [ "$new_brightness" -le 0 ]; then
         new_brightness=1
       fi
     fi
 
     echo "$new_brightness" > "$backlight_dir/brightness"
  '';
in{
  # Edit brightness without sudo
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    brightness-script
  ];
}