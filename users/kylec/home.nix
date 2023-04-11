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
    fish
    git
    git-crypt
    gnome.seahorse
    gnupg
    htop
    libsecret
    lsd
    nodenv
    magic-wormhole
    micro
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

  programs.fish = {
   enable = true;
   shellInit = ''
    set fish_color_param normal
    set fish_color_error red --bold
    set fish_color_command a0c980 --bold
   '';
   interactiveShellInit = ''
    set fish_cursor_default line
    bind \eg grepfiles
    bind \ep findfile

    if command --query starship
      starship init fish | source
    else
      echo 'starship not found!'
    end

    if command --query zoxide
      zoxide init fish | source
    else
      echo 'zoxide not found!'
    end
   '';
  };

  programs.gpg = {
    enable = true;
  };
 
  programs.neovim = {
    enable = true;
    defaultEditor = true;  
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
  
}
