{ config, pkgs, pkgsStable, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "ravicorreia";
    homeDirectory = "/home/ravicorreia";
  };
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.pointerCursor = {
    gtk.enable = true;
    name = "Banana";
    package = pkgs.banana-cursor;
    x11 = {
      enable = true;
      defaultCursor = "Banana";
    };
  };
  gtk = {
    enable = true;
    iconTheme = {
        package = pkgs.whitesur-icon-theme;
        name = "WhiteSur-dark";
      };
    cursorTheme = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 32;
    };
   };

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    # Garbage Colector
    gc = {
      automatic = true;
      frequency = "monthly";
    };
    # extraOptions = ''
    #   allowUnfree = true;
    # '';
  };

  #Enable/Config programs
  programs = {
    git = {
      enable = true;
      userName = "ravicorreia";
      userEmail = "ravicorreia@proton.me";
      signing = {
        key = null;
        signByDefault = false;
        format = "ssh";
      };

        # Outras configurações do Git aqui
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

# The home.packages option allows you to install unfree Nix packages into your environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [

      # basic pkgs
    vlc
    brave               # Browser
    google-chrome       # Browser
    discord             # All-in-one cross-platform voice and text chat
    vscode              # Text editor
    spotify             # Music Stream
    stremio             # Modern media center that gives you the freedom to watch everything you want
    obs-studio          # Free and open source software for video recording and live streaming
    timeshift           # System restore tool for Linux

      # dev pkgs
    lazygit
    direnv              # Shell extension that manages your environment
    nix-direnv          # Fast, persistent use_nix implementation for direnv
    zoxide              # Fast cd command that learns your habits
    httpie              # Command line HTTP client whose goal is to make CLI human-friendly
    bat                 # Cat(1) clone with syntax highlighting and Git integration
    neovim              # Text editor
    wl-clipboard        # Wayland clipboard functionality
    fastfetch           # A fetch, maybe I'll also test 'nitch' something like that
    gh                  # GitHub cli
    fzf                 # Fuzy Finder
    gcc                 # Compilor
    ripgrep             # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    fd                  # Simple, fast and user-friendly alternative to find
    cargo               # Rust's package manager and build system, it handles dependencies e.g. nil_ls for nix.
    # ghostty             # Terminal
    # tmux                # Terminal Multiplexer

      # fonts
    nerd-fonts.jetbrains-mono 

    #clang               # Compilor
    #gnumake             # Compilor
    #binutils            # Compilor
    #unzip               # Unzipper
    #gnutar              # Unzipper

  ] ++ (with pkgsStable; [
    # Here i can add some packages from stable branch e.g.
    # ghostty             # Terminal; STABLE VERSION
  ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.

  ".zshrc".source = link ~/dotfiles/config/zshrc/.zshrc;
  ".p10k.zsh".source = link ~/dotfiles/config/zshrc/.p10k.zsh;
  ".config/nvim".source = link ~/dotfiles/config/nvim;
  ".config/ghostty".source = link ~/dotfiles/config/ghostty;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ravicorreia/etc/profile.d/hm-session-vars.sh
  #
  
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "/bin/zsh";
    NIX_BUILD_SHELL = "/bin/zsh";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
