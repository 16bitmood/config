{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./cachix.nix
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
  networking.networkmanager.enable = true; # Enable networking

  # Time Zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.emacs = {
      enable = true;
  };
  
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


  # Nvidia Stuff
  services.xserver.videoDrivers = [ "nvidia" "amdgpu"];
  hardware.opengl.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      fira-code
    ];
  };

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
      cudatoolkit
      firefox
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.cudaSupport = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cachix
    gcc
    git
    htop
    # python
    python3
    vim
    wget
  ];
  
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "22.11"; # Don't Change

}
