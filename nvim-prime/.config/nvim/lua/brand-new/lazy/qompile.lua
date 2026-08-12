if true then
    return {}
end
return {
    -- "qompile",
    -- dir = "~/Documents/Desk/Apps/qompile",
    -- config = function()
    --     require("qompile").setup({})
    -- end

    "shadowmkj/qompile.nvim",
    config = function()
        require("qompile").setup()
    end,

}
