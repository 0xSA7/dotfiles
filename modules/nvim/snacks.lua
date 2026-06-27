-- ==========================================
-- SNACKS.NVIM (Core Utilities & UI)
-- ==========================================
local snacks_status, snacks = pcall(require, "snacks")
if snacks_status then
  snacks.setup({
    bigfile = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    
    dashboard = {
      enabled = true,
      -- 1. Explicitly override the layout to completely drop the startup module
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
      },
      -- 2. Inject our custom content into those sections
      preset = {
        header = [[
   ██████╗ ██╗  ██╗███████╗ █████╗ ███████╗               
  ██╔═████╗╚██╗██╔╝██╔════╝██╔══██╗╚════██║               
  ██║██╔██║ ╚███╔╝ ███████╗███████║    ██╔╝               
  ████╔╝██║ ██╔██╗ ╚════██║██╔══██║   ██╔╝                
  ╚██████╔╝██╔╝ ██╗███████║██║  ██║   ██║                 
   ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝                 
                                                       
         Systems Security & Kernel Engineer                
        ]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
          { icon = " ", key = "c", desc = "Config", action = ":e ~/dotfiles/modules/nvim/init.lua" },
          { icon = " ", key = "h", desc = "Cheat Sheet", action = ":e ~/dotfiles/modules/nvim/cheatsheet.md" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  })

  -- Global mappings for Snacks utilities
  vim.keymap.set("n", "<leader>un", function() snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
  vim.keymap.set("n", "<leader>bd", function() snacks.bufdelete() end, { desc = "Delete Buffer" })
  vim.keymap.set({ "n", "t" }, "<c-/>", function() snacks.terminal() end, { desc = "Toggle Terminal" })
end
