-- ==========================================
-- 1. EDITOR SETTINGS
-- ==========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

vim.g.mapleader = " "

-- ==========================================
-- 2. THEME SYNC (GNOME)
-- ==========================================
local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
if handle then
  local result = handle:read("*a")
  handle:close()

if result and result:match("prefer%-dark") then
  vim.cmd("colorscheme kanagawa-wave")
else
  vim.cmd("colorscheme kanagawa-lotus")
end
else
  vim.cmd("colorscheme kanagawa-wave")
end
-- ==========================================
-- 3. AUTOCOMPLETION & SNIPPETS (CMP)
-- ==========================================
local cmp_status, cmp = pcall(require, 'cmp')
local luasnip_status, luasnip = pcall(require, 'luasnip')

if cmp_status and luasnip_status then
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
  })
end

-- ==========================================
-- 4. LSP SERVERS ATTACHMENT
-- ==========================================
-- 1. Temporarily mute Neovim's built-in deprecation warnings
local original_deprecate = vim.deprecate
vim.deprecate = function() end

-- 2. Load LSP and CMP
local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
local cmp_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

if lspconfig_status and cmp_lsp_status then
  local capabilities = cmp_nvim_lsp.default_capabilities()
  local servers = { 'pyright', 'rust_analyzer', 'clangd', 'bashls', 'nil_ls' }

  -- 3. Setup servers
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
    })
  end
end

-- 4. Restore the deprecation function so we don't break other plugins
vim.deprecate = original_deprecate

-- ==========================================
-- 5. NEO-TREE (Modern File Explorer)
-- ==========================================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local neotree_status, neotree = pcall(require, 'neo-tree')
if neotree_status then
  -- Toggle tree with Ctrl+n
  vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { silent = true })
end

-- ==========================================
-- 6. LUALINE (Colorful Status Bar)
-- ==========================================
local lualine_status, lualine = pcall(require, 'lualine')
if lualine_status then
  lualine.setup({
    options = {
      theme = 'kanagawa', -- Syncs perfectly with your main theme
      section_separators = { left = '', right = ''},
      component_separators = { left = '', right = ''},
    }
  })
end

-- ==========================================
-- 7. BUFFERLINE (VSCode-like Tabs)
-- ==========================================
local bufferline_status, bufferline = pcall(require, 'bufferline')
if bufferline_status then
  vim.opt.termguicolors = true
  bufferline.setup({
    options = {
      diagnostics = "nvim_lsp", -- Show LSP errors directly in the tabs
      separator_style = "slant", -- Cool slanted edges
    }
  })
  -- Use Shift+H and Shift+L to navigate tabs
  vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { silent = true })
  vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { silent = true })
end

-- ==========================================
-- 9. TREESITTER CONTEXT
-- ==========================================
local ts_context_status, ts_context = pcall(require, 'treesitter-context')
if ts_context_status then
  ts_context.setup({
    enable = true,
    max_lines = 3, -- How many lines the context window should span
  })
end
-- ==========================================
-- 10. NOICE (Floating Command Line)
-- ==========================================
local noice_status, noice = pcall(require, 'noice')
if noice_status then
  noice.setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = false, 
      command_palette = true, 
      long_message_to_split = true, 
      inc_rename = false,
      lsp_doc_border = true, 
    },
    views = {
      cmdline_popup = {
        position = { row = "50%", col = "50%" },
        size = { width = 60, height = "auto" },
      },
      popupmenu = {
        relative = "editor",
        position = { row = 8, col = "50%" },
        size = { width = 60, height = 10 },
        border = { style = "rounded", padding = { 0, 1 } },
        win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
      },
    },
  })
end
-- ==========================================
-- 11. WHICH-KEY (Interactive Cheat Sheet)
-- ==========================================
local wk_status, wk = pcall(require, "which-key")
if wk_status then
  wk.setup({
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = false },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      border = "rounded",
    },
  })

  wk.add({
    { "<leader>f", group = "Find / Telescope" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (Text)" },
  })
end

-- ==========================================
-- 12. AI INTEGRATION (Supermaven)
-- ==========================================
local sm_status, sm = pcall(require, "supermaven-nvim")
if sm_status then
  sm.setup({
    keymaps = {
      accept_suggestion = "<C-f>",
      clear_suggestion = "<C-]>",
      accept_word = "<C-j>",
    },
    color = {
      suggestion_color = "#8a9a9b",
      cterm = 244,
    },
    disable_inline_completion = false,
    disable_keymaps = false
  })
end
-- ==========================================
-- 13. MARKDOWN PREVIEW
-- ==========================================
vim.g.mkdp_auto_close = 0
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_theme = 'dark'
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
-- ==========================================
-- 14. DISCORD RICH PRESENCE (Cord.nvim)
-- ==========================================
local cord_status, cord = pcall(require, "cord")
if cord_status then
  cord.setup({
    usercmds = true, 
    timer = {
      interval = 1500,
      reset_on_idle = false,
      reset_on_change = true,
    },
    display = {
      show_time = true,
      show_repository = true,
      show_cursor_position = true,
      swap_fields = false,
      swap_icons = false,
    },
    lsp = {
      show_problem_count = false,
      severity = 1,
      scope = "workspace",
    },
    idle = {
      show_idle = true,
      timeout = 300000, 
      disable_on_focus = false,
      text = "AFK",
      tooltip = "💤",
    },
  })
--    to do: Cord.nvim commands
  vim.api.nvim_create_user_command("CordConnect", function()
    local ok, api = pcall(require, "cord.api")
    if ok and api.connect then api.connect() end
  end, {})

  vim.api.nvim_create_user_command("CordDisconnect", function()
    local ok, api = pcall(require, "cord.api")
    if ok and api.disconnect then api.disconnect() end
  end, {})

  vim.keymap.set("n", "<leader>cr", "<cmd>CordConnect<CR>", { silent = true, desc = "Connect Discord" })
  vim.keymap.set("n", "<leader>cd", "<cmd>CordDisconnect<CR>", { silent = true, desc = "Disconnect Discord" })
  vim.keymap.set("n", "<leader>ct", "<cmd>CordTogglePresence<CR>", { silent = true, desc = "Toggle Discord Presence" })
else
  vim.notify("Cord.nvim failed to load: \n" .. tostring(cord), vim.log.levels.ERROR)
end
