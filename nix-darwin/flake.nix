{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

 home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      environment.systemPackages =
        [ 
	pkgs.vim
	# pkgs.zoxide
	# pkgs.ripgrep
	# pkgs.fd
	pkgs.curl
	# pkgs.fzf
	pkgs.git
	pkgs.nodejs_22
  pkgs.go
	# pkgs.lua
	pkgs.luajit
	# pkgs.luajit_2_0
	pkgs.luarocks
	# pkgs.tmux
	];
        # environment.shells = [ pkgs.bash pkgs.zsh ];
        # environment.loginShell = pkgs.zsh;
        # environment.systemPath = [ "/opt/homebrew/bin" ];
        # environment.pathsToLink = [ "/Applications" ];
      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      # system.stateVersion = 4;
      nixpkgs.hostPlatform = "x86_64-darwin";
      users.users.pantornchuavallee.home = "/Users/zen";

      home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;

        system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.LoginwindowText = "zen way";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
      };

        homebrew = {
              enable = true;
              caskArgs.no_quarantine = true;
              global.brewfile = true;
              masApps = { };
              # casks = [ "raycast" "amethyst" ];
              casks = [ "visual-studio-code" "docker" "wezterm"];
              # taps = [ "fujiapple852/trippy" ];
              # brews = [ "trippy" ];
              brews = [ "imagemagick" ];
            };
    };
  in
  {
    darwinConfigurations."Pantorns-MacBook-Air" = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };

      modules = [ 
      configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.pantornchuavallee = import ./home.nix;
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."Pantorns-MacBook-Air".pkgs;
  };
}
