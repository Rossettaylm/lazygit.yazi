return {
    entry = function()
        local output = Command("git"):arg("status"):stderr(Command.PIPED):output()
        if output.stderr ~= "" then
            ya.notify({
                title = "lazygit",
                content = "Not in a git directory\nError: " .. output.stderr,
                level = "warn",
                timeout = 5,
            })
        else
            permit = ui.hide and ui.hide() or ya.hide()
            local child, err_code = Command("lazygit"):stdin(Command.INHERIT):stdout(Command.INHERIT):stderr(Command.INHERIT):spawn()
            if child and not err_code then
                child:wait()
            end
        end
    end,
}
