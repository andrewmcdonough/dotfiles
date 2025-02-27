-- Set ALE to not lint on text change
vim.g.ale_lint_on_text_changed = 'never'

-- Configure ALE linters
vim.g.ale_linters = {
    javascript = {'eslint'},
    vue = {'eslint', 'prettier'},
    ruby = {'rubocop', 'ruby'},
    sass = {'sass_lint'},
    scss = {'sass_lint'},
}

-- Configure ALE fixers
vim.g.ale_fixers = {
    ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
    javascript = {'eslint', 'prettier'},
    typescript = {'eslint', 'prettier'},
    vue = {'eslint', 'prettier', 'stylelint'},
    ruby = {'rubocop'},
    go = {'golint'},
    scss = {'stylelint'},
}
