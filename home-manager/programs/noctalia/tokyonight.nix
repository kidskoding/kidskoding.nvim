let
  p = {
    bg = "#222436";
    bg_dark = "#1e2030";
    bg_highlight = "#2f334d";
    black = "#1b1d2b";
    fg = "#c8d3f5";
    fg_dark = "#828bb8";
    blue = "#82aaff";
    magenta = "#c099ff";
    orange = "#ff966c";
    red1 = "#c53b53";
    border_highlight = "#589ed7";
    bg_visual = "#2d3f76";
  };
in {
  mPrimary = p.blue;
  mOnPrimary = p.black;

  mSecondary = p.magenta;
  mOnSecondary = p.black;

  mTertiary = p.orange;
  mOnTertiary = p.black;

  mError = p.red1;
  mOnError = p.fg;

  mSurface = p.bg_dark;
  mOnSurface = p.fg;

  mSurfaceVariant = p.bg_highlight;
  mOnSurfaceVariant = p.fg_dark;

  mOutline = p.border_highlight;
  mShadow = p.black;

  mHover = p.bg_visual;
  mOnHover = p.fg;

  terminal = {
    normal = {
      black = "#1b1d2b";
      red = "#ff757f";
      green = "#c3e88d";
      yellow = "#ffc777";
      blue = "#82aaff";
      magenta = "#c099ff";
      cyan = "#86e1fc";
      white = "#828bb8";
    };

    bright = {
      black = "#444a73";
      red = "#ff8d94";
      green = "#c7fb6d";
      yellow = "#ffd8ab";
      blue = "#9ab8ff";
      magenta = "#caabff";
      cyan = "#b2ebff";
      white = "#c8d3f5";
    };

    foreground = p.fg;
    background = p.bg;
    cursor = p.fg;
    cursorText = p.bg;
    selectionFg = p.fg;
    selectionBg = p.bg_visual;
  };
}
