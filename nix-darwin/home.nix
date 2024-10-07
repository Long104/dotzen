# home.nix
# home-manager switch
{
  config,
  pkgs,
  ...
}: {
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

  # Install MacOS applications to the user environment if the targetPlatform is Darwin
 # my.home = { config, pkgs, ... }: {
 #    home.file."Applications/Home Manager Apps".source = let
 #      apps = pkgs.buildEnv {
 #        name = "home-manager-applications";
 #        paths = config.home.packages;
 #        pathsToLink = "/Applications";
 #      };
 #    in "${apps}/Applications";
 #
 #    home.sessionPath = [ "$HOME/.local/bin" ];
 #  };  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # Install macOS applications if the targetPlatform is Darwin
  home.file."Applications/Home Manager Apps".source = let
    apps = pkgs.buildEnv {
      name = "home-manager-applications";
      paths = config.home.packages;
      pathsToLink = [ "/Applications" ];
    };
  in "${apps}/Applications";

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
  };
}
