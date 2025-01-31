# home.nix
# home-manager switch
{
  config, pkgs,
  #test
  lib,
  inputs,
  ...
}: {
  # imports = [
  #   inputs.spicetify-nix.homeManagerModules.default
  #   # ./spicetify.nix ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "pantornchuavallee";
  home.homeDirectory = "/Users/pantornchuavallee";

  # home.stateVersion = "23.05"; # Please read the comment before changing.

  home.enableNixpkgsReleaseCheck = false;

  # Makes sense for user specific applications that shouldn't be available system-wide
  # home.packages = with pkgs; [
  home.packages = [
    pkgs.atuin
    pkgs.fastfetch
    pkgs.yazi
    pkgs.sesh
    pkgs.alejandra
    pkgs.gum
    pkgs.neovim
    pkgs.lazygit
    pkgs.ani-cli
    pkgs.atac
    pkgs.vesktop
    pkgs.imagemagick
    pkgs.bun
    pkgs.deno
    pkgs.ollama
    pkgs.starship
    # pkgs.llm-ls
    pkgs.pipx
    # pkgs.lua51Packages.luamagick
    # linter
    pkgs.hadolint
    pkgs.kubernetes-helm
    # lsp
    # pkgs.ltex-ls
    pkgs.ytfzf
    pkgs.lazydocker
    pkgs.ueberzugpp
    # docker
    pkgs.dive
    pkgs.docker-slim
  ];

  home.file = {
    ".config/aerospace".source = ../aerospace;
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
