{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Nix Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "gts-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Enable networking

  # Time Zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "en_IN";
  #   LC_IDENTIFICATION = "en_IN";
  #   LC_MEASUREMENT = "en_IN";
  #   LC_MONETARY = "en_IN";
  #   LC_NAME = "en_IN";
  #   LC_NUMERIC = "en_IN";
  #   LC_PAPER = "en_IN";
  #   LC_TELEPHONE = "en_IN";
  #   LC_TIME = "en_IN";
  # };
  
  systemd.services.disableTurbo = {
    script = ''
      echo "0" | tee /sys/devices/system/cpu/cpufreq/boost
    '';
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.disableFullCharge = {
    script = ''
      echo "60" | tee /sys/class/power_supply/BAT0/charge_control_end_threshold 
    '';
    wantedBy = [ "multi-user.target" ];
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkbOptions = "caps:escape";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gts = {
    isNormalUser = true;
    description = "Gurdit";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    htop
    git
    wget
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "22.11"; # Did you read the comment?

}
