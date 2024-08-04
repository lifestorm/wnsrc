--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

if SERVER then AddCSLuaFile() end

TFA = TFA or {}

local do_load = true
local version = 50.454
local version_string = "50.4.5.4.0"
local changelog = [[
	* Fixed bullet force value being completely ignored in favor of autocalculated one
	* Various inspection menu improvements (localized weapon type, multiline description with word wrap)
	* Fixed attachments not syncing properly from NPCs and other players
	* Fixed skins not updating on worldmodels
]]

local function testFunc()
end

local my_path = debug.getinfo(testFunc)
if my_path and type(my_path) == "table" and my_path.short_src then
	my_path = my_path["short_src"]
else
	my_path = "legacy"
end

if TFA_BASE_VERSION then
	if TFA_BASE_VERSION > version then
		print("You have a newer, conflicting version of TFA Base.")
		print("It's located at: " .. ( TFA_FILE_PATH or "" ) )
		print("Contact the author of that pack, not TFA.")
		do_load = false
	elseif TFA_BASE_VERSION < version then
		print("You have an older, conflicting version of TFA Base.")
		print("It's located at: " .. ( TFA_FILE_PATH or "" ) )
		print("Contact the author of that pack, not TFA.")
	elseif TFA_BASE_VERSION == version then
		print("You have an equal, conflicting version of TFA Base.")
		print("It's located at: " .. ( TFA_FILE_PATH or "" ) )
		print("Contact the author of that pack, not TFA.")
	end
end

local official_modules_sorted = {
	"tfa_commands.lua",
	"cl_tfa_commands.lua", -- we need to load clientside convars before anything else

	"tfa_data.lua",
	"tfa_ammo.lua",
	"tfa_attachments.lua",
	"tfa_ballistics.lua",
	"tfa_bodygroups.lua",

	"tfa_darkrp.lua",
	"tfa_effects.lua",
	"tfa_envcheck.lua",
	"tfa_functions.lua",
	"tfa_hooks.lua",
	"tfa_keybinds.lua",
	"tfa_keyvalues.lua",
	"tfa_matproxies.lua",
	"tfa_melee_autorun.lua",
	"tfa_meta.lua",
	"tfa_netcode.lua",
	"tfa_small_entities.lua",
	"tfa_npc_weaponmenu.lua",
	"tfa_nzombies.lua",
	"tfa_particles.lua",
	"tfa_snd_timescale.lua",
	"tfa_soundscripts.lua",
	"tfa_tttpatch.lua",

	"sv_tfa_settingsmenu.lua",

	"cl_tfa_attachment_icon.lua",
	"cl_tfa_attachment_panel.lua",
	"cl_tfa_attachment_tip.lua",
	"cl_tfa_changelog.lua",

	"cl_tfa_devtools.lua",
	"cl_tfa_fonts.lua",
	"cl_tfa_hitmarker.lua",
	"cl_tfa_inspection.lua",
	"cl_tfa_materials.lua",
	"cl_tfa_models.lua",
	"cl_tfa_particles_lua.lua",
	"cl_tfa_projtex.lua",
	"cl_tfa_rendertarget.lua",
	"cl_tfa_rtbgblur.lua",
	"cl_tfa_settingsmenu.lua",
	"cl_tfa_vgui.lua",
	"cl_tfa_vm_blur.lua",
	"cl_tfa_stencilsights.lua",
}

local official_modules = {}

for _, modulename in ipairs(official_modules_sorted) do
	official_modules[modulename] = true
end

if do_load then
	-- luacheck: globals TFA_BASE_VERSION TFA_BASE_VERSION_STRING TFA_BASE_VERSION_CHANGES TFA_FILE_PATH
	TFA_BASE_VERSION = version
	TFA_BASE_VERSION_STRING = version_string
	TFA_BASE_VERSION_CHANGES = changelog
	TFA_FILE_PATH = my_path

	TFA.Enum = TFA.Enum or {}

	local flist = file.Find("tfa/enums/*.lua","LUA")

	for _, filename in pairs(flist) do
		local typev = "SHARED"

		if filename:StartWith("cl_") then
			typev = "CLIENT"
		elseif filename:StartWith("sv_") then
			typev = "SERVER"
		end

		if SERVER and typev ~= "SERVER" then
			AddCSLuaFile("tfa/enums/" .. filename)
		end

		if SERVER and typev ~= "CLIENT" or CLIENT and typev ~= "SERVER" then
			include("tfa/enums/" .. filename)
		end
	end

	hook.Run("TFABase_PreEarlyInit")

	for _, filename in ipairs(official_modules_sorted) do
		if filename:StartWith("cl_") then
			if SERVER then
				AddCSLuaFile("tfa/modules/" .. filename)
			else
				include("tfa/modules/" .. filename)
			end
		elseif filename:StartWith("sv_") then
			if SERVER then
				include("tfa/modules/" .. filename)
			end
		else
			if SERVER then
				AddCSLuaFile("tfa/modules/" .. filename)
			end

			include("tfa/modules/" .. filename)
		end
	end

	hook.Run("TFABase_EarlyInit")
	hook.Run("TFABase_PreInit")

	flist = file.Find("tfa/modules/*.lua", "LUA")
	local toload = {}
	local toload2 = {}

	for _, filename in pairs(flist) do
		if not official_modules[filename] then
			local typev = "SHARED"

			if filename:StartWith("cl_") then
				typev = "CLIENT"
			elseif filename:StartWith("sv_") then
				typev = "SERVER"
			end

			if SERVER and typev ~= "SERVER" then
				AddCSLuaFile("tfa/modules/" .. filename)
			end

			if SERVER and typev == "SERVER" or CLIENT and typev == "CLIENT" then
				table.insert(toload2, filename)
			elseif typev == "SHARED" then
				table.insert(toload, filename)
			end
		end
	end

	local yell = #toload ~= 0 or #toload2 ~= 0

	table.sort(toload)
	table.sort(toload2)

	for _, filename in ipairs(toload) do
		include("tfa/modules/" .. filename)
		print("[TFA Base] [!] Loaded unofficial module " .. string.sub(filename, 1, -5) .. ".")
	end

	for _, filename in ipairs(toload2) do
		include("tfa/modules/" .. filename)
		print("[TFA Base] [!] Loaded unofficial module " .. string.sub(filename, 1, -5) .. ".")
	end

	hook.Run("TFABase_Init")
	hook.Run("TFABase_PreFullInit")

	flist = file.Find("tfa/external/*.lua", "LUA")
	toload = {}
	toload2 = {}

	for _, filename in pairs(flist) do
		local typev = "SHARED"

		if filename:StartWith("cl_") then
			typev = "CLIENT"
		elseif filename:StartWith("sv_") then
			typev = "SERVER"
		end

		if SERVER and typev ~= "SERVER" then
			AddCSLuaFile("tfa/external/" .. filename)
		end

		if SERVER and typev == "SERVER" or CLIENT and typev == "CLIENT" then
			table.insert(toload2, filename)
		elseif typev == "SHARED" then
			table.insert(toload, filename)
		end
	end

	table.sort(toload)
	table.sort(toload2)

	for _, filename in ipairs(toload) do
		include("tfa/external/" .. filename)
	end

	for _, filename in ipairs(toload2) do
		include("tfa/external/" .. filename)
	end

	if yell then
		print("[TFA Base] [!] Some of files not belonging to TFA Base were loaded from tfa/modules/ directory")
		print("[TFA Base] This behavior is kept for backward compatiblity and using this is highly discouraged!")
		print("[TFA Base] Files loaded this way have no pre-defined sorting applied and result of execution of those files is undefined.")
		print("[TFA Base] If you are author of these files, please consider moving your modules to tfa/external/ as soon as possible.")
	end

	hook.Run("TFABase_FullInit")

	if not VLL2_FILEDEF then
		TFAUpdateAttachments()
	end

	hook.Run("TFABase_LateInit")
end
