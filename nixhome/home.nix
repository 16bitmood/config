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
      fd
      fira-code
      gnome.dconf-editor
      gnome.gnome-tweaks
      gnome.gnome-power-manager
      gnome.gnome-shell-extensions
      libreoffice-qt
      powertop
      ripgrep
      hunspell
    ];
  };

  xdg.configFile."alacritty/alacritty.yml".source = ./.config/alacritty/alacritty.yml;
  home.file.".emacs.d/init.el".source = ./.emacs.d/init.el;
  home.file.".emacs.d/config.org".source = ./.emacs.d/config.org;

  programs = {
    alacritty = {
      enable = true;
    };

    bash = {
      enable = true;
      shellAliases = {
        ll = "ls -al";
        py = "python3";
        snix = "sudo nixos-rebuild --flake /home/gts/main/config#zephyrus switch";
        shome = "home-manager --flake /home/gts/main/config#gts@zephyrus switch";
      };
      bashrcExtra = ''
        function reload-emacs() {
            systemctl --user stop emacs
            systemctl --user start emacs
        }
      '';
    };

    git = {
      enable = true;
      userName  = "Gurdit Singh Siyan";
      userEmail = "16bitmood@gmail.com";
    };

    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };

  dconf.settings = import ./dconf.nix;

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}