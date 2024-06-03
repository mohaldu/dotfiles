
vim.g.mapleader = " " -- easy to reach leader key
vim.keymap.set("n", "-", vim.cmd.Ex) -- need nvim 0.8+


-- Function to toggle the terminal at the bottom with 30% height
function ToggleTerminal()
    -- Check if the terminal buffer exists and if it is valid
    local term_bufnr = vim.g.term_bufnr
    if term_bufnr ~= nil and vim.api.nvim_buf_is_valid(term_bufnr) then
        -- Check if the terminal window is open
        local windows = vim.api.nvim_list_wins()
        local term_win_found = false
        for _, win in ipairs(windows) do
            if vim.api.nvim_win_get_buf(win) == term_bufnr then
                term_win_found = true
                if vim.api.nvim_win_is_valid(win) then
                    -- If terminal window is found and valid, close it
                    vim.api.nvim_win_close(win, false)
                end
                break
            end
        end
        if not term_win_found then
            -- If terminal window is not found, reopen it
            vim.cmd("botright split | resize 30%")
            vim.api.nvim_win_set_buf(0, term_bufnr)
        end
    else
        -- Create a new terminal if it doesn't exist
        vim.cmd("botright 30sp | terminal")
        vim.g.term_bufnr = vim.api.nvim_get_current_buf()
    end
end

vim.keymap.set('n', '+', ToggleTerminal, {noremap = true, silent = true})
