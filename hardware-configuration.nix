# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # Boot loader settings
  
  # Resume device is the partition with the swapfile in this case
  boot.resumeDevice = "/dev/mapper/cryptroot";

  # Show Nixos logo while loading
  boot.plymouth.enable = true;

  boot.loader = {
    timeout = null;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    systemd-boot.enable = false;
    grub = {
      enable = true;
      version = 2;
      enableCryptodisk = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
      extraEntries = ''
        menuentry "Shutdown" {
          halt
        }
        menuentry "Reboot" {
          reboot
        }
      '';
    };
  };
  boot.kernelParams = [ "resume_offset=403456" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/05b0f515-f901-4bf3-afa9-f155cdc7ae7e";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-uuid/136355f2-8296-489d-a311-818fd958100e";
    preLVM = true;
    allowDiscards = true;
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6b8e779b-838a-433e-992c-e28ee70c7207";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/2B3C-E2E7";
      fsType = "vfat";
    };

  swapDevices = [{
    device = "/swapfile";
    #priority = 0;
    size = 16384;
  }];

  nix.maxJobs = lib.mkDefault 16;
}
