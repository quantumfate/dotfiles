-- Full rounded border around the panes (your old lf `set drawbox`, nicer).
require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

-- Record every directory you visit into the zoxide database, like your old
-- lf `on-cd` hook. Lets `z <query>` jump to frecent dirs.
require("zoxide"):setup({
	update_db = true,
})
