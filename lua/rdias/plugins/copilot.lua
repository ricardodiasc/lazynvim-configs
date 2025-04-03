return {
  "github/copilot.vim",
  config = function ()
    vim.g.copilot_no_tab_map = true

    local keymap = vim.keymap

    keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true, replace_keycodes = false, desc = "Accept Copilot suggestion" })
    -- keymap.set("i", "<C-K>", 'copilot#Dismiss()', { expr = true, silent = true, replace_keycodes = false, desc = "Dismiss Copilot suggestion" })
    keymap.set("i", "<C-Right>", 'copilot#Next()', { expr = true, silent = true, replace_keycodes = false, desc = "Next Copilot suggestion" })
    keymap.set("i", "<C-Left>", 'copilot#Previous()', { expr = true, silent = true, replace_keycodes = false, desc = "Previous Copilot suggestion" })
  end

}
