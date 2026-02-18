-- for clangd
vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--log=verbose"
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    single_file_support = true,
})
vim.lsp.enable("clangd");

