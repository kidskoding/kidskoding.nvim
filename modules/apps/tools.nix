{...}: {
  flake.homeModules.anirudh = {pkgs, ...}: {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
      };
    };

    home.packages = with pkgs; [
      # applications
      basalt
      discord
      doxygen_gui
      harlequin
      libreoffice
      myx
      obsidian
      popsicle
      ruffle
      spotify
      teams-for-linux
      zathura
      zoom-us

      # other really cool stuff!!
      asciiquarium-transparent
      cava
      cowsay
      dua
      fortune
      ghostscript
      gum
      imagemagick
      mermaid-cli
      pipes
      presenterm
      tickrs
      timr-tui
      tldr
      wtf

      # user utilities
      rclone
      sshfs

      # fonts
      nerd-fonts.symbols-only
      nerd-fonts.terminess-ttf
      symbola
      corefonts

      # cloud
      awscli2
    ];
  };
}
