{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  # See: https://github.com/nix-community/home-manager/issues/2942 
  nixpkgs.config.allowUnfreePredicate = (pkg: true); 

  home = {
    username = "gts";
    homeDirectory = "/home/gts";
    packages = with pkgs; [
      alacritty
      discord
      emacs
      gnome.dconf-editor
      gnome.gnome-tweaks
      gnome.gnome-power-manager
      gnome.gnome-shell-extensions
      vscode
    ];
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        window = {
          dimensions = {
            columns = 60;
            lines = 20;
          };
          padding = {
            x = 20;
            y = 20;
          };
          decoration = "false";
        };
        font.size = 11;
      };
    };

    bash = {
      enable = true;
      shellAliases = {
        ll = "ls -al";
        snix = "sudo nixos-rebuild --flake /home/gts/main/config#zephyrus switch";
        shome = "home-manager --flake /home/gts/main/config#gts@zephyrus switch";
      };
    };

    git = {
      enable = true;
      userName  = "Gurdit Singh Siyan";
      userEmail = "16bitmood@gmail.com";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      "color-scheme" = "prefer-dark";
      "text-scaling-factor" = 1.2;
    };

    "org/gnome/shell/keybindings" = {
      "switch-to-application-1" = [];
      "switch-to-application-2" = [];
      "switch-to-application-3" = [];
      "switch-to-application-4" = [];
      "switch-to-application-5" = [];
      "switch-to-application-6" = [];
      "switch-to-application-7" = [];
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Shift><Super>q"];
      "move-to-workspace-1" = ["<Shift><Super>exclam"];
      "move-to-workspace-2" = ["<Shift><Super>at"];
      "move-to-workspace-3" = ["<Shift><Super>numbersign"];
      "move-to-workspace-4" = ["<Shift><Super>dollar"];
      "switch-to-workspace-1" = ["<Super>1"];
      "switch-to-workspace-2" = ["<Super>2"];
      "switch-to-workspace-3" = ["<Super>3"];
      "switch-to-workspace-4" = ["<Super>4"];
      "switch-to-workspace-last" = [];
      "toggle-fullscreen" = ["<Super>f"];
    };

    "org/gnome/mutter" = {
      "experimental-features" = ["scale-monitor-framebuffer"];
    };
 

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      email = [];
      help = [];
      home = [];
      magnifier = [];
      magnifier-zoom-in = [];
      magnifier-zoom-out = [];
      screenreader = [];
      terminal = [];
      volume-down = ["<Super>minus"];
      volume-up = ["<Super>equal"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "alacritty";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "emacs";
      name = "emacs";
    };

    "org/gnome/desktop/wm/preferences" = {
      "num-workspaces" = 7;
    };

    "org/gnome/desktop/input-sources" = {
      "xkb-options" = ["caps:escape" "altwin:swap_alt_win"];
    };
  };

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
