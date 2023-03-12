{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kylec";
  home.homeDirectory = "/home/kylec";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bottom
    brave
    git
    git-crypt
    gnome.seahorse
    gnupg
    libsecret
    lsd
    magic-wormhole-rs
    neofetch
    pinentry-gnome
    rustup
    starship
    stow
    fd
    wl-clipboard
    zoxide
  ];
  
  programs.git = {
    enable = true;
    userName = "Kyle Cierzan";
    userEmail = "kcierzan@gmail.com";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";
    };
  };

  programs.gpg = {
    enable = true;
  };
  
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
  
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      return {
        color_scheme = 'kanagawabones',
        default_cursor_style = 'SteadyBar',
        font = wezterm.font('Iosevka'),
        hide_tab_bar_if_only_one_tab = true,
        scrollback_lines = 50000
      }
    '';
  };
  
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      zoxide init fish | source
      starship init fish | source
    '';
    shellAliases = {
      gs = "git status";
      be = "bundle exec";
      la = "lsd -lah";
      hole = "wormhole-rs";
    };
  };
  
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
  
}
