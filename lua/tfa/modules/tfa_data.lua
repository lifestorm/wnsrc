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

-- This file is holding seamless translation of older versions of data to newer
-- versions of data

TFA.LatestDataVersion = 1

TFA.DataVersionMapping = {
	[0] = {
		{
			old_path = "DrawCrosshairIS",
			new_path = "DrawCrosshairIronSights",
		},

		{
			old_path = "FiresUnderwater",
			new_path = "Primary.FiresUnderwater",
		},

		{
			old_path = "PenetrationMaterials",
			new_path = "Primary.PenetrationMaterials",
		},

		{
			old_path = "MaxPenetrationCounter",
			new_path = "Primary.MaxSurfacePenetrationCount",
		},

		{
			old_path = "MaxPenetration",
			new_path = "Primary.MaxSurfacePenetrationCount",
		},

		{
			old_path = "IronRecoilMultiplier",
			new_path = "Primary.IronRecoilMultiplier",
		},

		{
			old_path = "MoveSpeed",
			new_path = "RegularMoveSpeedMultiplier",
		},

		{
			old_path = "IronSightsMoveSpeed",
			new_path = "AimingDownSightsSpeedMultiplier",
		},

		{
			old_path = "Shotgun",
			new_path = "LoopedReload",
		},

		{
			old_path = "ShellTime",
			new_path = "LoopedReloadInsertTime",
		},

		{
			old_path = "CrouchPos",
			new_path = "CrouchViewModelPosition",
		},

		{
			old_path = "CrouchAng",
			new_path = "CrouchViewModelAngle",
		},

		{
			old_path = "data.ironsights",
			new_path = "Secondary.IronSightsEnabled",
			upgrade = function(value) return value == 1 end,
			downgrade = function(value) return value and 1 or 0 end,
		},

		{
			old_path = "Secondary.IronFOV",
			new_path = "Secondary.OwnerFOV",
		},

		{
			old_path = "IronViewModelFOV",
			new_path = "Secondary.ViewModelFOV",
		},

		{
			old_path = "DoProceduralReload",
			new_path = "IsProceduralReloadBased",
		},

		{
			old_path = "ProceduralReloadEnabled",
			new_path = "IsProceduralReloadBased",
		},

		{
			old_path = "Akimbo",
			new_path = "IsAkimbo",
		},

		{
			old_path = "AkimboHUD",
			new_path = "EnableAkimboHUD",
		},

		{
			old_path = "IronInSound",
			new_path = "Secondary.IronSightsInSound",
		},

		{
			old_path = "IronOutSound",
			new_path = "Secondary.IronSightsOutSound",
		},

		{
			old_path = "DisableChambering",
			new_path = "Primary.DisableChambering",
		},

		{
			old_path = "DisplayFalloff",
			new_path = "Primary.DisplayFalloff",
		},

		{
			old_path = "SpreadPattern",
			new_path = "Primary.SpreadPattern",
		},

		{
			old_path = "SpreadBiasYaw",
			new_path = "Primary.SpreadBiasYaw",
		},

		{
			old_path = "SpreadBiasPitch",
			new_path = "Primary.SpreadBiasPitch",
		},

		{
			old_path = "VMPos",
			new_path = "ViewModelPosition",
		},

		{
			old_path = "VMAng",
			new_path = "ViewModelAngle",
		},

		{
			old_path = "VMPos_Additive",
			new_path = "AdditiveViewModelPosition",
		},

		{
			old_path = "RunSightsPos",
			new_path = "SprintViewModelPosition",
		},

		{
			old_path = "RunSightsAng",
			new_path = "SprintViewModelAngle",
		},

		{
			old_path = "IronSightsPos",
			new_path = "IronSightsPosition",
		},

		{
			old_path = "IronSightsAng",
			new_path = "IronSightsAngle",
		},

		{
			old_path = "Bodygroups_V",
			new_path = "ViewModelBodygroups",
		},

		{
			old_path = "Bodygroups_W",
			new_path = "WorldModelBodygroups",
		},

		{
			old_path = "CenteredPos",
			new_path = "CenteredViewModelPosition",
		},

		{
			old_path = "CenteredAng",
			new_path = "CenteredViewModelAngle",
		},

		{
			old_path = "Offset",
			new_path = "WorldModelOffset",
		},

		{
			old_path = "ProceduralHolsterPos",
			new_path = "ProceduralHolsterPosition",
		},

		{
			old_path = "ProceduralHolsterAng",
			new_path = "ProceduralHolsterAngle",
		},

		{
			old_path = "VElements",
			new_path = "ViewModelElements",
		},

		{
			old_path = "WElements",
			new_path = "WorldModelElements",
		},
	}
}

local function identity(...) return ... end

for version = 0, #TFA.DataVersionMapping do
	for i, data in ipairs(TFA.DataVersionMapping[version]) do
		if not isfunction(data.upgrade) then data.upgrade = identity end
		if not isfunction(data.downgrade) then data.downgrade = identity end
	end
end

TFA.PathParseCache = {}
TFA.PathParseCacheTR = {}
TFA.StatPathRemapCache = {}
TFA.PathParseCacheDirect = {}
TFA.PathParseChildren = {}

local PathParseCache = TFA.PathParseCache
local PathParseCacheTR = TFA.PathParseCacheTR
local PathParseCacheDirect = TFA.PathParseCacheDirect
local StatPathRemapCache = TFA.StatPathRemapCache
local PathParseChildren = TFA.PathParseChildren
local string_Explode = string.Explode
local ipairs = ipairs
local pairs = pairs
local string_sub = string.sub
local tonumber = tonumber
local table_Copy = table.Copy
local table_concat = table.concat
local istable = istable
local string_format = string.format

local function doDowngrade(path, migrations)
	for i, data in ipairs(migrations) do
		if data.new_path == path then
			return data.old_path, data.upgrade
		elseif path:StartWith(data.new_path) and path[#data.new_path + 1] == '.' then
			return data.old_path .. path:sub(#data.new_path + 1), data.upgrade
		end
	end

	return path
end

local function doUpgrade(path, migrations)
	for i, data in ipairs(migrations) do
		if data.old_path == path then
			return data.new_path, data.downgrade
		elseif path:StartWith(data.old_path) and path[#data.old_path + 1] == '.' then
			return data.new_path .. path:sub(#data.old_path + 1), data.downgrade
		end
	end

	return path
end

function TFA.RemapStatPath(path, path_version, structure_version)
	local cache_path = path

	if path_version == nil then path_version = 0 end
	if structure_version == nil then structure_version = 0 end

	-- version do not match
	if path_version ~= structure_version then
		cache_path = string_format("%d_%d_%s", path_version, structure_version, path)
	end

	local get_cache = StatPathRemapCache[cache_path]
	if get_cache ~= nil then return get_cache end

	if cache_path ~= path then
		-- downgrade path
		if path_version > structure_version then
			for version = path_version, structure_version, -1 do
				local mapping = TFA.DataVersionMapping[version]

				if istable(mapping) then
					path = doDowngrade(path, mapping)
				end
			end
		else -- upgrade path
			for version = path_version, structure_version do
				local mapping = TFA.DataVersionMapping[version]

				if istable(mapping) then
					path = doUpgrade(path, mapping)
				end
			end
		end
	end

	StatPathRemapCache[cache_path] = path
	return StatPathRemapCache[cache_path]
end

function TFA.GetStatPathChildren(path, path_version, structure_version)
	-- version do not match
	if path_version ~= structure_version then
		path = TFA.RemapStatPath(path, path_version, structure_version)
	end

	if not PathParseChildren[path] then
		TFA.GetStatPath(path, path_version, structure_version)
	end

	return PathParseChildren[path].list
end

local function concat_to(tab, to)
	local str = tab[1]

	for i = 2, to do
		str = str .. '.' .. tab[i]
	end

	return str
end

local function concat_from(tab, from)
	local str = tab[from]

	for i = from + 1, #tab do
		str = str .. '.' .. tab[i]
	end

	return str
end

function TFA.GetStatPath(path, path_version, structure_version, no_translate)
	local cache_path = path

	if path_version == nil then path_version = 0 end
	if structure_version == nil then structure_version = 0 end

	-- version do not match
	if path_version ~= structure_version then
		cache_path = string_format("%d_%d_%s", path_version, structure_version, path)
	end

	local _PathParseCache = no_translate and PathParseCacheTR or PathParseCache
	local get_cache = _PathParseCache[cache_path]
	if get_cache ~= nil then return get_cache[1], get_cache[2], get_cache[3] end

	local fn, fnGet

	if cache_path ~= path then
		-- downgrade
		if path_version > structure_version then
			for version = path_version, structure_version, -1 do
				local mapping = TFA.DataVersionMapping[version]

				if istable(mapping) then
					path, fnGet = doDowngrade(path, mapping)

					if fnGet and fnGet ~= identity then
						if not fn then
							fn = fnGet
						else
							local _fn = fn
							function fn(...) return fnGet(_fn(...)) end
						end
					end
				end
			end
		else -- upgrade
			for version = path_version, structure_version do
				local mapping = TFA.DataVersionMapping[version]

				if istable(mapping) then
					path, fnGet = doUpgrade(path, mapping)

					if fnGet and fnGet ~= identity then
						if not fn then
							fn = fnGet
						else
							local _fn = fn
							function fn(...) return fnGet(_fn(...)) end
						end
					end
				end
			end
		end
	end

	get_cache = string_Explode(".", path, false)

	do
		local children = PathParseChildren[get_cache[1]]

		if not children then
			children = {
				list = {get_cache[1]},
				children = {}
			}

			PathParseChildren[get_cache[1]] = children
		end

		local childrens = {children}

		for i = 2, #get_cache do
			local obj = get_cache[i]
			local path2 = concat_to(get_cache, i)

			for i3 = 1, #childrens do
				local list = childrens[i3].list
				local hit = false

				for i2 = 1, #list do
					if list[i2] == path2 then
						hit = true
						break
					end
				end

				if not hit then
					table.insert(list, path2)
				end
			end

			if not children.children[obj] then
				children.children[obj] = {
					list = {path2},
					children = {}
				}
			end

			if not PathParseChildren[path2] then
				PathParseChildren[path2] = {
					list = {path2},
					children = {}
				}
			end

			children = children.children[obj]
			table.insert(childrens, children)
			table.insert(childrens, PathParseChildren[path2])
		end
	end

	if not no_translate then
		if get_cache[1] == "Primary" then
			get_cache[1] = "Primary_TFA"
		elseif get_cache[1] == "Secondary" then
			get_cache[1] = "Secondary_TFA"
		end
	end

	for k, v in ipairs(get_cache) do
		get_cache[k] = tonumber(v) or v
	end

	_PathParseCache[cache_path] = {get_cache, path, fn or identity}
	return get_cache, path, fn or identity
end

function TFA.GetStatPathRaw(path)
	local get_cache = PathParseCacheDirect[path]
	if get_cache ~= nil then return get_cache end

	local t_stbl = string_Explode(".", path, false)

	for k, v in ipairs(t_stbl) do
		t_stbl[k] = tonumber(v) or v
	end

	PathParseCacheDirect[path] = t_stbl
	return t_stbl
end

local GetStatPathRaw = TFA.GetStatPathRaw

do
	local function get(self, path)
		local value = self[path[1]]

		for i = 2, #path do
			if not istable(value) then return end
			value = value[path[i]]
		end

		return value
	end

	local function set(self, path, val)
		if #path == 1 then
			if self[path[1]] == nil then
				self[path[1]] = val
			end

			return
		end

		local value = self[path[1]]

		if value == nil then
			self[path[1]] = {}
			value = self[path[1]]
		end

		for i = 2, #path - 1 do
			if not istable(value) then return end
			if value[path[i]] == nil then value[path[i]] = {} end
			value = value[path[i]]
		end

		if istable(value) and value[path[#path]] == nil then
			value[path[#path]] = val
		elseif not istable(value) then
			print('[TFA Base] unable to fill gap for older version in meta structure of ' .. table_concat(path, '.'))
		end
	end

	function TFA.FillMissingMetaValues(SWEP)
		for version = TFA.LatestDataVersion, 0, -1 do
			local mapping = TFA.DataVersionMapping[version]

			if istable(mapping) then
				for i, data in ipairs(mapping) do
					local getVal = get(SWEP, GetStatPathRaw(data.new_path))

					if getVal ~= nil then
						set(SWEP, GetStatPathRaw(data.old_path), data.downgrade(getVal))
					end
				end
			end
		end
	end
end
