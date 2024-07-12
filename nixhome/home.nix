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
      appimage-run
      busybox
      chromium
      cloc
      discord
      emacs
      fd
      file
      fira-code
      gimp
      gnome.dconf-editor
      gnome.gnome-tweaks
      gnome.gnome-power-manager
      gnome.gnome-shell-extensions
      haskell.compiler.ghc92
      hunspell
      julia-bin
      john
      kaggle
      libreoffice-qt
      mupdf
      nodejs
      octave
      pciutils
      protonvpn-cli
      protonvpn-gui
      powertop
      (python3.withPackages (ps: with ps; [ 
        beautifulsoup4
        ipython
        jupyter
        matplotlib
        networkx
        numpy
        opencv4
        openpyxl
        pandas
        pyarrow
        pylint
        pwntools
        requests
        scikit-learn
        scikitimage
        seaborn
        setuptools
        statsmodels
        torch
        torchvision
        tqdm
      ]))
      qt5.qtwayland
      ripgrep
      rustup
      spotify
      texlive.combined.scheme-full 
      tree
      webcord
      zip
    ];
  };

  xsession.enable = true;

  xdg.configFile."alacritty/alacritty.yml".source = ./.config/alacritty/alacritty.yml;
  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = ./.config/nvim;
    };
    ".emacs.d" = {
      recursive = true;
      source = ./.emacs.d;
    };
  };

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

        function check-turbo() {
          cat /sys/devices/system/cpu/cpufreq/boost
        }

        function sudo-disable-turbo() {
          echo "0" | sudo tee /sys/devices/system/cpu/cpufreq/boost
        }

        function check-chargelimit() {
          cat /sys/class/power_supply/BAT0/charge_control_end_threshold 
        }

        function sudo-disable-fullcharge() {
          echo "60" | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold 
        }

        function sudo-enable-fullcharge() {
          echo "100" | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold 
        }

        function sudo-disable-backlight() {
            echo "0" | sudo tee '/sys/class/leds/asus::kbd_backlight/brightness'
        }
      '';
    };

    git = {
      enable = true;
      userName  = "Gurdit Singh Siyan";
      userEmail = "16bitmood@gmail.com";
    };

    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      extraConfig = ''
        lua <<EOF
          require('bootstrap')
          require('variables')
          require('functions')
          require('keybinds')

          vim.cmd('colorscheme base16-ashes')

          require("which-key").setup {}
        EOF
      '';
      plugins = with pkgs.vimPlugins; [
        nvim-base16
        lush-nvim

        which-key-nvim
        indent-blankline-nvim
        nvim-colorizer-lua
        
        goyo-vim
        limelight-vim

        gitsigns-nvim

        plenary-nvim

        vim-sandwich
        vim-commentary

        nvim-autopairs

        vim-python-pep8-indent
        markdown-preview-nvim

        nvim-treesitter
        telescope-nvim
        popup-nvim
        telescope-project-nvim
      ];
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
