{ config, pkgs, lib, nixpkgs, ... }:

{
  deployment = {
    buildOnTarget = true;
    targetHost = "neurolink.bee-liberty.ts.net";
  };

  imports = ["${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"];

  nixpkgs.system = "aarch64-linux";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = "neurolink";
    wireless = {
      enable = true;
      userControlled.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
      vim
      htop
      tmux
      wavemon
  ];

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    passwordAuthentication = false;
    # kbdInteractiveAuthentication = false;
  };
  
  services.kea.dhcp4 = {
    enable = true;
    settings = {
      interfaces-config = {
        interfaces = [
          "eth0"
        ];
      };
      lease-database = {
        name = "/var/lib/kea/dhcp4.leases";
        persist = true;
        type = "memfile";
      };
      rebind-timer = 2000;
      renew-timer = 1000;
      subnet4 = [
        {
          pools = [
            {
              pool = "192.168.2.100 - 192.168.2.240";
            }
          ];
          subnet = "192.0.2.0/24";
        }
      ];
      valid-lifetime = 4000;
    };
  };
  
  services.tailscale.enable = true;

  users = {
    users."tjhu" = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}

