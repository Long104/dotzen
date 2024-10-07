# home.nix
# home-manager switch
{
  config,
  pkgs,
  #test
  lib,
  ...
}: let
  apps = pkgs.buildEnv {
    name = "home-manager-applications";
    paths = config.home.packages;
    pathsToLink = "/Applications";
  };
  me = "pantornchuavallee";
in {
  # home.activation.addApplications = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   echo "setting up ~/Applications/Home Manager Apps..." >&2
  #   nix_apps="$HOME/Applications/Home Manager Apps"
  #
  #   # Delete the directory to remove old links
  #   $DRY_RUN_CMD rm -rf "$nix_apps"
  #   $DRY_RUN_CMD mkdir -p "$nix_apps"
  #
  #   $DRY_RUN_CMD find ${apps}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
  #       while read src; do
  #           # Spotlight does not recognize symlinks, it will ignore directory we link to the applications folder.
  #           # It does understand MacOS aliases though, a unique filesystem feature. Sadly they cannot be created
  #           # from bash (as far as I know), so we use the oh-so-great Apple Script instead.
  #           /usr/bin/osascript -e "
  #               set fileToAlias to POSIX file \"$src\"
  #               set applicationsFolder to POSIX file \"$nix_apps\"
  #
  #               tell application \"Finder\"
  #                   make alias file to fileToAlias at applicationsFolder
  #                   # This renames the alias; 'mpv.app alias' -> 'mpv.app'
  #                   set name of result to \"$(rev <<< "$src" | cut -d'/' -f1 | rev)\"
  #               end tell
  #           " 1>/dev/null
  #       done
  # '';

    # system.activationScripts.applications.text = pkgs.lib.mkForce (''
    home.activationScripts.applications.text = pkgs.lib.mkForce (''
      echo "setting up ~/Applications/Nix..."
      rm -rf ~/Applications/Nix
      mkdir -p ~/Applications/Nix
      chown ${me} ~/Applications/Nix
      find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
        src="$(/usr/bin/stat -f%Y $f)"
        appname="$(basename $src)"
        osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Users/${me}/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
    done
  '');



  home.username = "pantornchuavallee";
  home.homeDirectory = "/Users/pantornchuavallee";
  # home.stateVersion = "23.05"; # Please read the comment before changing.

  # Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
    pkgs.atuin
    pkgs.fastfetch
    pkgs.yazi
    pkgs.sesh
    pkgs.alejandra
    pkgs.gum
    pkgs.neovim
    pkgs.lazygit
    pkgs.atac
    pkgs.vesktop
  ];


  home.file = {
    ".zshrc".source = ../zshrc/.zshrc;
    ".config/wezterm".source = ../wezterm;
    ".config/starship".source = ../starship.toml;
    ".config/nvim".source = ../nvim;
    ".config/ShoshiNvim".source = ../ShoshiNvim;
    ".config/nix-darwin".source = ../nix-darwin;
    ".tmux.conf".source = ../.tmux.conf;
    ".config/sesh".source = ../sesh;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    #test
    "$HOME/.local/bin"

    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "pantorn";
    userEmail = "longpantorn@gmail.com";
  };
  programs.zsh = {
    enable = true;
    # eval "$(/opt/homebrew/bin/brew shellenv)"
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';

    # enableCompletion = true;
    # enableAutosuggestions =true;
    # enableSyntaxHighlighting =true;
     # shellAliases = { ls = "ls"; };

  };

  # programs.bat.enable = true;
  # programs.bat.config.theme ="TwoDark" ;
  #
  # programs.fzf.enable = true;
  # programs.fzf.enableZshIntegration = true;
  #
  # programs.eza.enable = true;
  #
  # programs.starship.enable = true;
  # programs.starship.enableZshIntegration = true;
  #
  # program.alacritty = {
  #     enable = true;
  #     setting.font.normal.family = "MesloLGS Nerd Font Mono";
  #     setting.font.font = 16;
  #   };


}
