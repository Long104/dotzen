{config, ...}: {
  homebrew = {
    enable = true;
    # taps = builtins.attrNames config.nix-homebrew.taps;
    global = {
      # nix-homebrew is handling homebrew updates
      autoUpdate = false;
      brewfile = true;
    };
    onActivation = {
      # "zap" removes manually installed brews and casks
      # nix-homebrew is handling homebrew updates

      cleanup = "zap";
      autoUpdate = false;
      upgrade = true;

      # autoUpdate = true;
      # cleanup = "uninstall";
      # upgrade = true;
    };

    caskArgs = {no_quarantine = true;};

    casks = [
      "visual-studio-code"
      "docker"
      "wezterm"

      # -- essentials --
      # "1password"
      # "google-chrome"
      # "raycast"
      # "vlc"
      #
      # # -- utilities --
      # "surfshark"
      # "finicky" # choose browser on each link
      # "vmware-fusion"
      # "adobe-acrobat-reader"
      # "dropbox"
      # "google-drive"
      # "teamviewer"
      # "todoist"
      # "yubico-yubikey-manager"
      # "trezor-suite"
      # "kindavim"
      # "gimp"
      # "chatgpt"
      #
      # # -- 3d printing
      # "bambu-studio"
      # "orcaslicer"
      #
      # # -- communication --
      # "telegram"
      # "signal"
      # "discord"
      # "whatsapp"
      # "element"
      #
      # # -- work --
      # "firefox"
      # "krisp"
      # "leapp"
      # "slack"
      # "docker"
      # "microsoft-teams"
      # "postman"
    ];

    brews = [
      "imagemagick"
    ];
    # masApps = {
    #   "1Password for Safari" = 1569813296;
    #   "Dark Reader for Safari" = 1438243180;
    #   "WiFi Signal" = 525912054;
    #   "Xcode" = 497799835;
    # };
  };
}
