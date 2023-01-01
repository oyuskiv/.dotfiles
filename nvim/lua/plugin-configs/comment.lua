local ok, comment = pcall(require, 'Comment')
if not ok then
    vim.notify("Comment is not installed")
    return
end

comment.setup()
