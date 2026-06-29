return {
	"nvimdev/dashboard-nvim",
	lazy = false,
	opts = function()
		local cwd = vim.fn.getcwd():gsub("\\", "/")

		local obsidian_path = "C:/Users/user/Documents/Project_150"
		local is_obsidian = cwd:find(obsidian_path, 1, true) ~= nil

		local obsidian_logo = [[
 ██████╗  ██████╗  ███████╗ ██╗ ██████╗  ██╗  █████╗  ███╗   ██╗
██╔═══██╗ ██╔══██╗ ██╔════╝ ██║ ██╔══██╗ ██║ ██╔══██╗ ████╗  ██║
██║   ██║ ██████╔╝ ███████╗ ██║ ██║  ██║ ██║ ███████║ ██╔██╗ ██║
██║   ██║ ██╔══██╗ ╚════██║ ██║ ██║  ██║ ██║ ██╔══██║ ██║╚██╗██║
╚██████╔╝ ██████╔╝ ███████║ ██║ ██████╔╝ ██║ ██║  ██║ ██║ ╚████║
 ╚═════╝  ╚═════╝  ╚══════╝ ╚═╝ ╚═════╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═══╝
]]

		local default_logo = [[
██╗  ██╗  ██████╗  ██████╗  ██╗ ███████╗  ██████╗  ███╗   ██╗
██║  ██║ ██╔═══██╗ ██╔══██╗ ██║ ╚══███╔╝ ██╔═══██╗ ████╗  ██║
███████║ ██║   ██║ ██████╔╝ ██║   ███╔╝  ██║   ██║ ██╔██╗ ██║
██╔══██║ ██║   ██║ ██╔══██╗ ██║  ███╔╝   ██║   ██║ ██║╚██╗██║
██║  ██║ ╚██████╔╝ ██║  ██║ ██║ ███████╗ ╚██████╔╝ ██║ ╚████║
╚═╝  ╚═╝  ╚═════╝  ╚═╝  ╚═╝ ╚═╝ ╚══════╝  ╚═════╝  ╚═╝  ╚═══╝
]]

		local logo

		if is_obsidian then
			logo = obsidian_logo
		else
			logo = default_logo
		end
		--    local logo = [[
		--██╗  ██╗  ██████╗  ██████╗  ██╗ ███████╗  ██████╗  ███╗   ██╗
		--██║  ██║ ██╔═══██╗ ██╔══██╗ ██║ ╚══███╔╝ ██╔═══██╗ ████╗  ██║
		--███████║ ██║   ██║ ██████╔╝ ██║   ███╔╝  ██║   ██║ ██╔██╗ ██║
		--██╔══██║ ██║   ██║ ██╔══██╗ ██║  ███╔╝   ██║   ██║ ██║╚██╗██║
		--██║  ██║ ╚██████╔╝ ██║  ██║ ██║ ███████╗ ╚██████╔╝ ██║ ╚████║
		--╚═╝  ╚═╝  ╚═════╝  ╚═╝  ╚═╝ ╚═╝ ╚══════╝  ╚═════╝  ╚═╝  ╚═══╝
		--    ]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		-- Standard Coding Menu
		local default_center = {
			{
				action = "lua LazyVim.pick()()",
				desc = " Find Files",
				icon = " ",
				icon_hl = "DashboardIcon",
				key = "f",
			},
			{
				action = "ene | startinsert",
				desc = " Craft ",
				icon = " ",
				icon_hl = "DashboardIcon",
				key = "n",
			},
			{
				action = 'lua LazyVim.pick("oldfiles")()',
				desc = " Archive",
				icon = " ",
				icon_hl = "DashboardIcon",
				key = "r",
			},
			{
				action = 'lua LazyVim.pick("live_grep")()',
				desc = " Trace Text",
				icon = " ",
				icon_hl = "DashboardIcon",
				key = "g",
			},
			{
				action = "lua LazyVim.pick.config_files()()",
				desc = " Engine",
				icon = " ",
				icon_hl = "DashboardIcon",
				key = "c",
			},
			{
				action = 'lua require("persistence").load()',
				desc = " Time Machine",
				icon = " ",
				icon_hl = "DashboardIcon",
				key = "s",
			},
			{
				action = "LazyExtras",
				desc = " Marketplace",
				icon = " ",
				icon_hl = "DashboardIcon",
				key = "x",
			},
			{
				action = "Lazy",
				desc = " Lazy",
				icon = "󰒲 ",
				icon_hl = "DashboardIcon",
				key = "l",
			},
			{
				action = function()
					vim.api.nvim_input("<cmd>qa<cr>")
				end,
				desc = " Terminate",
				icon = " ",
				icon_hl = "DashboardIcon",
				key = "q",
			},
		}

		-- Obsidian Personal Brain Menu
		local obsidian_center = {
			{
				action = "ObsidianToday",
				desc = " Chronos (Daily)",
				icon = "󰃭 ",
				key = "t",
			},
			{
				action = 'lua LazyVim.pick("find_files")()',
				desc = " Nexus (Switch)",
				icon = "󱞎 ",
				key = "f",
			},
			{
				action = "ObsidianQuickSwitch",
				desc = " Portal (Quick)",
				icon = "󱞎 ",
				key = "p",
			},
			{
				action = "ObsidianSearch",
				desc = " Trace (Grep)",
				icon = "󰱼 ",
				key = "g",
			},
			{
				action = "ObsidianTags",
				desc = " Taxonomy (Tags)",
				icon = "󰓹 ",
				key = "s",
			},
			{
				action = "ObsidianNew",
				desc = " Craft (New Note)",
				icon = "󱞒 ",
				key = "n",
			},
			{
				action = "Lazy",
				desc = " Engine (Lazy)",
				icon = " ",
				key = "c",
			},
			{
				action = function()
					vim.api.nvim_input("<cmd>qa<cr>")
				end,
				desc = " Terminate",
				icon = " ",
				key = "q",
			},
		}
		local active_center = is_obsidian and obsidian_center or default_center

		local opts = {
			theme = "doom",
			hide = {
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = active_center,
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return {
						"󱐋 Tweaked by priyanshuf11 󱐋",
						"⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. ms .. "ms",
					}
				end,
			},
		}

		if is_obsidian then
			-- Obsidian purple theme
			vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#A78BFA" })
			vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#C4B5FD" })
			vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#E9D5FF" })
			vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#8B5CF6" })
			vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#7C3AED" })
		else
			--- Neon Cyber-Teal Highlight Colors
			vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#00f5d4" }) -- Neon Mint/Teal (Greenish Blue Glow)
			vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#7efff5" }) -- Neon Ice (Kept for subtle highlights)
			vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#ffffff" }) -- Pure Star-White
			vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#009485" }) -- Deep Jungle Teal (Darker color for labels)
			vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#3d5afe" }) -- Bright Electric Blue (Increased readability)
		end

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		if vim.o.filetype == "lazy" then
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = tostring(vim.api.nvim_get_current_win()),
				once = true,
				callback = function()
					vim.schedule(function()
						vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
					end)
				end,
			})
		end

		return opts
	end,
}
