local wk = require("which-key")
local prefix = { prefix = "<leader>" }

local get_term_cmds = function(num)
	return {
		name = "Terminal " .. num,
		h = {
			function()
				require("toggleterm").toggle_command("direction=horizontal", num)
			end,
			"Toggle Terminal",
		},
		f = {
			function()
				require("toggleterm").toggle_command("direction=float", num)
			end,
			"Toggle Terminal",
		},
		v = {
			function()
				require("toggleterm").toggle_command("direction=vertical size=60", num)
			end,
			"Toggle Terminal",
		},
	}
end
local Terminal = function()
	return require("toggleterm.terminal").Terminal
end
local MusicPlayer = nil
local toggleMusicPlayer = function()
	if MusicPlayer == nil then
		MusicPlayer = Terminal():new({ cmd = "ncmpcpp", hidden = true, direction = "float" })
	end
	MusicPlayer:toggle()
end
local toggleMidnightCommander = function ()
    Terminal():new({cmd = "mc", hidden = true, direction = "float"}):toggle()
end

local toggleterm = function()
	local toggleterm_keymaps = {
		r = {
			name = "Terminal",
			h = {
				function()
					require("toggleterm").toggle_command("direction=horizontal", nil)
				end,
				"Toggle Terminal",
			},
			f = {
				function()
					require("toggleterm").toggle_command("direction=float", nil)
				end,
				"Toggle Terminal",
			},
			v = {
				function()
					require("toggleterm").toggle_command("direction=vertical size=60", nil)
				end,
				"Toggle Terminal",
			},
		},
		f = {
			m = {
				function()
					toggleMusicPlayer()
				end,
				"Toggle music player",
			},
		},
        m = {
            c = {
                function()
                    toggleMidnightCommander()
                end,
                "Toggle External File Explorer",

            },
        },
	}
	for i = 1, 9 do
		toggleterm_keymaps.r[tostring(i)] = get_term_cmds(i)
	end
	wk.register({
		toggleterm_keymaps,
	}, prefix)
	wk.register({
		["<Escape>"] = {
			"<C-\\><C-n>",
			"Escape terminal",
		},
	}, { mode = "t" })
end

return toggleterm

