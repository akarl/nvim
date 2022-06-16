vim.cmd([[
    let g:neoterm_autoscroll = 1

    let test#go#gotest#options = '-race -coverprofile=c.out'

    " let test#strategy = "neoterm"
    let test#strategy = "tslime"
]])
