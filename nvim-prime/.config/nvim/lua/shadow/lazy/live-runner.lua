return {
    "shadowmkj/nvim-live-runner",
    build = "cd src && go build -o server",
    config = function()
        require("live-runner").setup({})
    end,
}
