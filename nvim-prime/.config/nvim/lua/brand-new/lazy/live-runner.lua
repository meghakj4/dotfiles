return {
    -- "nvim-live-runner",
    -- dir = "~/Documents/Desk/Apps/nvim-live-runner",
    -- build = "cd src && go build -o server",
    -- config = function()
    --     require("live-runner").setup({})
    -- end
    "shadowmkj/nvim-live-runner",
    build = "cd src && go build -o server",
    config = function()
        require("live-runner").setup({})
    end,
}
