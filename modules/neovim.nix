{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pyright
    rust-analyzer
    clang-tools
    bash-language-server
    nil
    nerd-fonts.jetbrains-mono
    nodejs
  ];


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
    
    plugins = with pkgs.vimPlugins; [
      kanagawa-nvim
      nvim-treesitter.withAllGrammars
      telescope-nvim
      plenary-nvim 
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      nvim-web-devicons
      which-key-nvim
      mini-icons
      # ==========================
      #  UI Stack
      # ==========================
      neo-tree-nvim
      nui-nvim                 # UI library for neo-tree
      lualine-nvim             # statusline
      bufferline-nvim          # tabs
      snacks-nvim              # snacks-nvim
      nvim-treesitter-context  # function headers
      alpha-nvim               # dashboard
      noice-nvim               # floating UI 
      markdown-preview-nvim    # markdown-preview-nvim
      supermaven-nvim          # maven
      cord-nvim                # cord 
    ];

      initLua = ''
      ${builtins.readFile ./nvim/init.lua}
      ${builtins.readFile ./nvim/snacks.lua}
    '';
  };
}
