{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "blogi"; # Define your hostname.
  
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  services.nginx = {
    enable = true;
    virtualHosts."neosam.dev" = {
      forceSSL = true;
      enableACME = true;
      default = true;
      locations."/" = {
        proxyPass = "http://localhost:8080";
      };
    };
  };

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    wget vim psmisc
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  # 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.blog = {
    isNormalUser = true;
  };
  users.users.neosam = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
