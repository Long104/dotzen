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
in {

# home.activation = {
#   aliasApplications = lib.hm.dag.entryAfter ["writeBoundary"] ''
#     app_folder="$(echo ~/Applications)/Home Manager Apps"
#     home_manager_app_folder="$genProfilePath/home-path/Applications"
#     $DRY_RUN_CMD rm -rf "$app_folder"
#     $DRY_RUN_CMD mkdir "$app_folder"
#     for app in $(find "$newGenPath/home-path/Applications" -type l -exec readlink -f {} \;)
#     do
#       $DRY_RUN_CMD /usr/bin/osascript \
#         -e "tell app \"Finder\"" \
#         -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" \
#         -e "set name of result to \"$(basename $app)\"" \
#         -e "end tell"
#     done
#   '';
# };

  home.activation = {
    copyApplications = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      baseDir="$HOME/Applications/Home Manager Apps"
      if [ -d "$baseDir" ]; then
        rm -rf "$baseDir"
      fi
      mkdir -p "$baseDir"
      for appFile in ${apps}/Applications/*; do
        target="$baseDir/$(basename "$appFile")"
        $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
        $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
      done
    '';
  };




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
