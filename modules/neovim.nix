{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withRuby = false;
    withPython3 = false;
    vimAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      kanagawa-nvim
      nvim-treesitter.withAllGrammars
      telescope-nvim
      plenary-nvim 
    ];
    
    extraConfig = ''
      set number
      set relativenumber
      set shiftwidth=2
      set tabstop=2
      set expandtab
      set smartindent
      set termguicolors
      
      let mapleader = " "

      " Auto-Sync with GNOME Theme dynamically
      lua << EOF
        local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme")
        local result = handle:read("*a")
        handle:close()

        if result and result:match("prefer%-dark") then
          vim.cmd("colorscheme kanagawa-wave")
        else
          vim.cmd("colorscheme kanagawa-lotus")
        end
      EOF
    '';
  };
}
