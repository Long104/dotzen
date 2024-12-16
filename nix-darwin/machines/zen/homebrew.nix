{config, ...}: {
  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
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
      "arc"
      "raycast"
      "chatgpt"
      "whatsapp"
      "postman"
      "spotify"
      "aldente"
      "obsidian"
      "iina"
      # "nikitabobko/tap/aerospace"
    ];

    brews = [
      "qemu"
      "imagemagick"
      "asdf"
      "luarocks"
      "pkg-config"
      "luajit"
      "lua"
      "colima"
      "docker"
      "kubectl"
      "docker-compose"
      "git-lfs"
      # ani cli dependencies below
      "aria2"
      "ffmpeg"
      "yt-dlp"
      "nasm"

      # "jmeter"
    ];

    masApps = {
      # "1Password for Safari" = 1569813296;
      # "Dark Reader for Safari" = 1438243180;
      # "WiFi Signal" = 525912054;
      # "Xcode" = 497799835;

      # "Microsoft Excel" = 462058435;
      # "Microsoft Word" = 462054704;
      "LINE" = 539883307;
    };
  };
}
