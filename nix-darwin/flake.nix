{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nix-darwin.url = "github:LnL7/nix-darwin";
    # nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "darwin";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-services = {
      url = "github:homebrew/homebrew-services";
      flake = false;
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-services,
    # homebrew-bundle,
    ...
  } @ inputs: let
    configuration = {pkgs, ...}: {
      # environment.systemPackages = [
      #   pkgs.vim
      #   pkgs.zoxide
      #   pkgs.ripgrep
      #   pkgs.fd
      #   pkgs.curl
      #   pkgs.eza
      #   pkgs.fzf
      #   pkgs.git
      #   pkgs.nodejs_22
      #   pkgs.go
      #   pkgs.bat
      #   pkgs.cargo
      #   pkgs.rustc
      #   # pkgs.lua
      #   pkgs.luajit
      #   # pkgs.luajit_2_0
      #   pkgs.luarocks
      #   pkgs.pam-reattach
      #   pkgs.tmux
      #   pkgs.htop
      # ];

      # environment.shells = [ pkgs.bash pkgs.zsh ];
      # environment.loginShell = pkgs.zsh;
      # environment.systemPath = [ "/opt/homebrew/bin" ];
      # environment.pathsToLink = [ "/Applications" ];
      # services.nix-daemon.enable = true;
      # nix.settings.experimental-features = "nix-command flakes";

      # users.users.${user} = {
      #     home = "/Users/${user}";
      #     shell = pkgs.zsh;
      #   };

      nix = {
        settings = {
          allowed-users = ["root" "pantornchuavallee"];
          trusted-users = ["root" "pantornchuavallee"];
          experimental-features = ["nix-command" "flakes"];

          # https://github.com/NixOS/nix/issues/7273
          auto-optimise-store = false;

          # needed for devenv to enable cachix
          accept-flake-config = true;
        };
        gc = {
          automatic = true;
          interval = {
            Hour = 12;
          };
          options = "--delete-old";
        };
      };

      # programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      # system.stateVersion = 4;
      nixpkgs.hostPlatform = "x86_64-darwin";
      security.pam.enableSudoTouchIdAuth = true;
      users.users.pantornchuavallee.home = "/Users/zen";

      home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = true;
      # nix.useDaemon = true;

      # system.defaults = {
      #   dock.autohide = true;
      #   dock.mru-spaces = false;
      #   finder.AppleShowAllExtensions = true;
      #   finder.FXPreferredViewStyle = "clmv";
      #   loginwindow.LoginwindowText = "zen way";
      #   screencapture.location = "~/Pictures/screenshots";
      #   screensaver.askForPasswordDelay = 10;
      # };

      # homebrew = {
      #   enable = true;
      #
      #   # group = "admin";
      #
      #   caskArgs.no_quarantine = true;
      #   global.brewfile = true;
      #   masApps = {};
      #   # casks = [ "raycast" "amethyst" ];
      #   casks = ["visual-studio-code" "docker" "wezterm"];
      #   # taps = [ "fujiapple852/trippy" ];
      #   # brews = [ "trippy" ];
      #   brews = ["imagemagick"];
      # };
    };
  in {
    darwinConfigurations."Pantorns-MacBook-Air" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import inputs.nixpkgs {system = "aarch64-darwin";};
      specialArgs = {inherit inputs;};
      modules = [
        ./machines/zen/configuration.nix
        ./machines/zen/homebrew.nix

        configuration

        # home-manager.darwinModules.home-manager
        # {
        #   extraSpecialArgs = {inherit inputs;};
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        #   home-manager.users.pantornchuavallee = import ./home.nix;
        # }
         home-manager.darwinModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            # makes all inputs available in imported files for hm
            extraSpecialArgs = {inherit inputs;};
            users.pantornchuavallee = {...}: {
              # imports = [shared ./home-manager/eve];
              imports = [./home.nix];
              home.file.".hushlogin".text = "";
              # home.stateVersion = stateVersion;
            };
          };
        }

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            enableRosetta = false;
            # User owning the Homebrew prefix
            user = "pantornchuavallee";
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-services" = homebrew-services;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
            mutableTaps = false;
            # autoMigrate = true;
          };
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."Pantorns-MacBook-Air".pkgs;
  };
}
