return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				-- Web Development
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				sass = { "prettier" },
				less = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },

				-- Python
				python = { "isort", "black" },

				-- Lua
				lua = { "stylua" },

				-- C/C++
				c = { "clang-format" },
				cpp = { "clang-format" },

				-- C#
				cs = { "csharpier" },

				-- F#
				fsharp = { "fantomas" },
			},
			-- format_on_save = {
			--   lsp_fallback = true,
			--   async = false,
			--   timeout_ms = 3000,
			-- },
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
