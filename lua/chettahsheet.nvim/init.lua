local M = {}

function M.chettahsheet()
    local input = vim.fn.input("ﲉ ", "", "file")
    local cmd = ""

    if input == "" then
        return
    elseif input == "h" then
        cmd = ""
    else
        local lang = ""
        local search = ""
        local delimiter = " "
        for w in (input .. delimiter):gmatch("(.-)" .. delimiter) do
            if lang == "" then
                lang = w
            else
                if search == "" then
                    search = w
                else
                    search = search .. "+" .. w
                end
            end
        end
        cmd = lang
        if search ~= "" then
            cmd = cmd .. "/" .. search
        end
    end
    M.chettahsheet_cmd(cmd)
end

function M.chettahsheet_cmd(cmd)
    local bufhandle = vim.api.nvim_create_buf(false, true)

    local width = math.floor(vim.o.columns * 0.7)
    local height = math.floor(vim.o.lines * 0.7)

    local top = math.floor(((vim.o.lines - height) / 2) - 1)
    local left = math.floor((vim.o.columns - width) / 2)

    local float_opts = {
        relative = 'editor',
        row = top,
        col = left,
        width = width,
        height = height,
        border = "single",
    }

    local winhandle = vim.api.nvim_open_win(bufhandle, true, float_opts)
    vim.api.nvim_exec("terminal curl -s cht.sh/" .. cmd, true)
    vim.cmd [[stopinsert]]

end

return M
