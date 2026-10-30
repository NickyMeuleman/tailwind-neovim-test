vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	-- v2 is still unstable (2026-10)
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/nvim-mini/mini.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"tsc",
		"tailwindcss",
	},
})

local servers = {
	tsc = {},
	-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tailwindcss.lua
	tailwindcss = {},
}

-- swatch instead of background highlight
-- vim.lsp.document_color.enable(true, nil, { style = "■ " })

for name, config in pairs(servers) do
	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

-- https://cmp.saghen.dev/recipes.html#completion-menu-drawing
local function get_mini_icon(ctx)
	if ctx.source_name == "Path" then
		local is_unknown_type =
			vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
		local mini_icon, mini_hl, _ = require("mini.icons").get(
			is_unknown_type and "os" or ctx.item.data.type,
			is_unknown_type and "" or ctx.label
		)
		if mini_icon then
			return mini_icon, mini_hl
		end
	end
	local mini_icon, mini_hl, _ = require("mini.icons").get("lsp", ctx.kind)
	return mini_icon, mini_hl
end

---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
	completion = {
		documentation = { auto_show = true },
		menu = {
			draw = {
				treesitter = { "lsp" },
				components = {
					kind_icon = {
						text = function(ctx)
							local hex = require("blink.cmp.sources.lsp.hacks.tailwind").get_hex_color(ctx.item)
							if hex then
								return "󱓻"
							end
							local icon, _ = get_mini_icon(ctx)
							return icon or "󰆧"
						end,
						highlight = function(ctx)
							local hex = require("blink.cmp.sources.lsp.hacks.tailwind").get_hex_color(ctx.item)
							if hex then
								local hl = "BlinkTwColor_" .. hex:gsub("#", "")
								if vim.fn.hlID(hl) == 0 then
									vim.api.nvim_set_hl(0, hl, { fg = hex, default = true })
								end
								return hl
							end
							local _, hl = get_mini_icon(ctx)
							return hl or ("BlinkCmpKind" .. ctx.kind)
						end,
					},
					kind = {
						highlight = function(ctx)
							local _, hl = get_mini_icon(ctx)
							return hl
						end,
					},
				},
			},
		},
	},
	signature = { enabled = true },
	cmdline = { completion = { menu = { auto_show = true } } },
})
