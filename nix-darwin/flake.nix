{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05"; # Stable version
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    # nix-darwin,
    darwin,
    nixpkgs,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-services,
    homebrew-bundle,
    ...
  } @ inputs: let
    configuration = {pkgs, ...}: {
      # environment.shells = [ pkgs.bash pkgs.zsh ];
      # environment.loginShell = pkgs.zsh;
      # environment.systemPath = [ "/opt/homebrew/bin" ];
      # environment.pathsToLink = [ "/Applications" ];

      users.users.pantornchuavallee = {
        home = "/Users/pantornchuavallee";
        shell = pkgs.zsh;
      };

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

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      # nixpkgs.hostPlatform = "x86_64-darwin";
      nixpkgs.hostPlatform = "aarch64-darwin";

      home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = true;
    };
  in {
    darwinConfigurations."Pantorns-MacBook-Air" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import inputs.nixpkgs {system = "aarch64-darwin";};
      specialArgs = {inherit inputs;};
      modules = [
        ./machines/zen/configuration.nix
        ./machines/zen/homebrew.nix

        configuration

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
              home.stateVersion = "23.05"; # Please read the comment before changing.
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
