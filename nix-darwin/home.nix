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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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
