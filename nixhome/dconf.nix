{
    "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
        "color-scheme" = "prefer-dark";
        "text-scaling-factor" = 1;
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
        "move-to-workspace-4" = ["<Shift><Super>4"];
        "switch-windows" = ["<Super>Tab"];
        "switch-applications" = [];
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
        command = "bash -c 'export WINIT_UNIX_BACKEND=x11 && export WINIT_X11_SCALE_FACTOR=1.0 && alacritty'";
        name = "alacritty";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>e";
        command = "emacsclient -c ~/main/org/startup.org";
        name = "emacs";
    };

    "org/gnome/desktop/wm/preferences" = {
        "num-workspaces" = 7;
    };

    "org/gnome/desktop/input-sources" = {
        "xkb-options" = ["caps:escape" "altwin:swap_alt_win"];
    };
}