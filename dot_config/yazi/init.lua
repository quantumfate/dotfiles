require("git"):setup({
	-- Order of status signs showing in the linemode
	order = 1500,
})

-- Full rounded border around the panes (your old lf `set drawbox`, nicer).
require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

-- Record every directory you visit into the zoxide database, like your old
-- lf `on-cd` hook. Lets `z <query>` jump to frecent dirs.
require("zoxide"):setup({
	update_db = true,
})

require("yafg"):setup({
	toggle_mode_key = "alt-t", -- fzf key to switch ripgrep/fzf mode (default: "ctrl-t")
	editor = "nvim", -- Editor command (default: "hx")
	args = { "--noplugin" }, -- Additional editor arguments (default: {})
	file_arg_format = "+{row} {file}", -- File argument format (default: "{file}:{row}:{col}")
})

require("restore"):setup({
	-- Set the position for confirm and overwrite prompts.
	-- Don't forget to set height: `h = xx`
	-- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
	position = { "center", w = 70, h = 40 }, -- Optional

	-- Show confirm prompt before restore.
	-- NOTE: even if set this to false, overwrite prompt still pop up
	show_confirm = true, -- Optional

	-- Suppress success notification when all files or folder are restored.
	suppress_success_notification = true, -- Optional

	-- colors for confirm and overwrite prompts
	theme = { -- Optional
		-- Default using style from your flavor or theme.lua -> [confirm] -> title.
		-- If you edit flavor or theme.lua you can add more style than just color.
		-- Example in theme.lua -> [confirm]: title = { fg = "blue", bg = "green"  }
		title = "blue", -- Optional. This value has higher priority than flavor/theme.lua

		-- Default using style from your flavor or theme.lua -> [confirm] -> content
		-- Sample logic as title above
		header = "green", -- Optional. This value has higher priority than flavor/theme.lua

		-- header color for overwrite prompt
		-- Default using color "yellow"
		header_warning = "yellow", -- Optional
		-- Default using style from your flavor or theme.lua -> [confirm] -> list
		-- Sample logic as title and header above
		list_item = { odd = "blue", even = "blue" }, -- Optional. This value has higher priority than flavor/theme.lua
	},
})

require("recycle-bin"):setup()

-- Woosh
--
-- You can configure your bookmarks using simplified syntax
local bookmarks = {
	{ tag = "Desktop", path = "~/Desktop", key = "d" },
	{ tag = "Documents", path = "~/Documents", key = "D" },
	{ tag = "Downloads", path = "~/Downloads", key = "o" },
}

-- You can also configure bookmarks with key arrays
local bookmarks = {
	{ tag = "Desktop", path = "~/Desktop", key = { "d", "D" } },
	{ tag = "Documents", path = "~/Documents", key = { "d", "d" } },
	{ tag = "Downloads", path = "~/Downloads", key = "o" },
}

require("whoosh"):setup({
	-- Configuration bookmarks (cannot be deleted through plugin)
	bookmarks = bookmarks,

	-- Notification settings
	jump_notify = false,

	-- Key generation for auto-assigning bookmark keys
	keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

	-- Configure the built-in menu action hotkeys
	-- false - hide menu item
	special_keys = {
		create_temp = "<Enter>", -- Create a temporary bookmark from the menu
		fuzzy_search = "<Space>", -- Launch fuzzy search (fzf)
		history = "<Tab>", -- Open directory history
		previous_dir = "<Backspace>", -- Jump back to the previous directory
		project_root = "-", -- Jump to the current Git repository root
	},

	-- File path for storing user bookmarks
	bookmarks_path = (
		ya.target_family() == "windows"
		and os.getenv("APPDATA") .. "\\yazi\\config\\plugins\\whoosh.yazi\\bookmarks"
	) or (os.getenv("HOME") .. "/.config/yazi/plugins/whoosh.yazi/bookmarks"),

	-- Replace home directory with "~"
	home_alias_enabled = true, -- Toggle home aliasing in displays

	-- Path truncation in navigation menu
	path_truncate_enabled = false, -- Enable/disable path truncation
	path_max_depth = 3, -- Maximum path depth before truncation

	-- Path truncation in fuzzy search (fzf)
	fzf_path_truncate_enabled = false, -- Enable/disable path truncation in fzf
	fzf_path_max_depth = 5, -- Maximum path depth before truncation in fzf

	-- Long folder name truncation
	path_truncate_long_names_enabled = false, -- Enable in navigation menu
	fzf_path_truncate_long_names_enabled = false, -- Enable in fzf
	path_max_folder_name_length = 20, -- Max length in navigation menu
	fzf_path_max_folder_name_length = 20, -- Max length in fzf

	-- History directory settings
	history_size = 10, -- Number of directories in history (default 10)
	history_fzf_path_truncate_enabled = false, -- Enable/disable path truncation by depth for history
	history_fzf_path_max_depth = 5, -- Maximum path depth before truncation for history (default 5)
	history_fzf_path_truncate_long_names_enabled = false, -- Enable/disable long folder name truncation for history
	history_fzf_path_max_folder_name_length = 30, -- Maximum length for folder names in history (default 30)
})
