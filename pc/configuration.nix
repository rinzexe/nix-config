# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
hardware.opengl = {
  enable = true;
driSupport32Bit = true;
};
hardware.nvidia = {
  modesetting.enable = true;  # Enables Wayland support for Nvidia
  powerManagement.enable = true;
  open = true;
};


hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
};



  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fi";
    variant = "winkeys";
  };
  
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure console keymap
  console.keyMap = "fi";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rinz = {
    isNormalUser = true;
    description = "rinz";
    extraGroups = [ "networkmanager" "wheel" "input" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  
  security.sudo.extraConfig = ''
  %wheel ALL=(ALL) NOPASSWD: ALL
  '';

virtualisation.docker.enable = true;
virtualisation.docker.enableNvidia = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "rinz";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  boot.supportedFilesystems = [ "fuse" ];
  
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    mesa
    libva
    libdrm
    vim
    vulkan-tools
    vulkan-loader
    libglvnd
    flatpak
    libdecor
    virtualbox
    libGL
    poetry
    fuse
    virt-manager
    virt-viewer
    win-virtio
    win-spice
    spice
    spice-gtk
    spice-protocol
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    libnotify
    gtk3
    python3
    python3Packages.pip
    python3Packages.virtualenv
    pkgs.python310Packages.numpy
    neofetch
    picom
    wget
    nix-tree
    solaar
    jq
    obs-studio
    alacritty
    alsa-lib     
    linuxPackages.nvidia_x11
    gh           
    libGLU pkgs.libGL
    xorg.libXi 
    xorg.libXmu
    heroic 
    freeglut
    xorg.libXext 
    xorg.libX11 
    xorg.libXv 
    xorg.libXrandr 
    zlib
    glib
    openssl 
    ncurses5 pkgs.binutils
    ffmpeg
    libappindicator-gtk3
    vscode-fhs
    bash
    discord
    xdotool
    appimage-run
    spotify
    git
    notion-app-enhanced
    pinta
    wine
    winetricks
    lutris
    winePackages.full
    winePackages.staging
    steam
    steam-run
    sysbench
    cachix
    gnome-keyring
    zig
    telegram-desktop
    unityhub
    github-desktop
    blender
    krita
    libwacom
    input-remapper
    gnome-randr
    opentabletdriver
    xf86_input_wacom
    mono
    msbuild
    lmms
    ardour
    figma-linux 
    nodejs
    inkscape
    osu-lazer 
];

environment.gnome.excludePackages = [pkgs.geary];
  
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;  # Temporarily true until we set up keys
      PermitRootLogin = "no";
    };
  };
  
  fonts.packages = with pkgs; [ noto-fonts-cjk-sans ];
  
  fonts = { 
  fontconfig = {
  antialias = true; 
  }; 
};

programs.nix-ld.enable = true;
programs.nix-ld.libraries = with pkgs; [

];


security.polkit.enable = true;

hardware.opentabletdriver = {
  enable = true;
  daemon.enable = true;
};

services.input-remapper.enable = true;

  services.udev.extraRules = ''
    # Huion Q630M tablet
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
    SUBSYSTEM=="input", ATTRS{idVendor}=="256c", ATTRS{idProduct}=="0060", MODE="0666"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="256c", ATTRS{idProduct}=="0060", MODE="0666"
    ACTION=="add|change", SUBSYSTEM=="input", ATTRS{idVendor}=="256c", ATTRS{idProduct}=="0060", ENV{LIBINPUT_TABLET_PAD}="1"
  '';

programs.dconf.enable = true;

environment.variables.NIXPKGS_ALLOW_UNFREE = "1";
environment.variables.CACHIX_AUTH_TOKEN="eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzYzA2MTFlMC0yMzFhLTQ3Y2UtOTZjZC1mYWU1ODRhZjQ5YmMiLCJzY29wZXMiOiJjYWNoZSJ9.qCw_oYDw7DWDm4Nawz5Go4o9QvzGxjc3CEB9ucXUsw4";

nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
    virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  
    services.spice-vdagentd.enable = true;

 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 57621 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
