--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- ZAPC
-- Copyright (c) 2012 Zaubermuffin
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

ENT.Type = 'anim'
ENT.Base = 'base_anim'
ENT.PrintName = 'Combine APC'
ENT.Author = 'Zaubermuffin'
ENT.Information = "Beep beep woop woop"
ENT.Category = 'Half-Life 2'

ENT.Spawnable = false
ENT.AdminSpawnable = false

-- Some constants that we are going to need - those need to be shared and synchronized on client and server.
ZAPC_VIEW_UNRELATED, ZAPC_VIEW_DRIVER, ZAPC_VIEW_GUNNER, ZAPC_VIEW_PASSENGER = 0, 1, 2, 3

-- No properties. No.
local function CanProperty(ply, act, ent)
	if not IsValid(ent) then
		return
	end
	
	-- Disclaimer: I can't be certain if it's related to an APC or not, so I'll make a few... educated guesses.
	-- If anyone ever runs into an issue with not being able to do stuff with the (a bit borked) APC model, let me know I suppose.
	if ent:GetModel() == 'models/combine_apc.mdl' and ent:GetClass() == 'prop_vehicle_jeep' and (act == 'bonemanipulate' or act == 'drive' or act == 'persist') then
		return false
	elseif ent:GetClass() == 'prop_vehicle_zapc_rocket' then
		return false
	end
end
hook.Add('CanProperty', '_ZAPCCanProperty', CanProperty)

-- Add it to the "Vehicles" tab under "Half-Life 2".
list.Set("Vehicles", "prop_vehicle_zapc", { Name = ENT.PrintName, Author = ENT.Author, Category = ENT.Category, Model = 'models/combine_apc.mdl', Information = 'A drivable combine APC', Class = 'prop_vehicle_zapc' })

--[[ CVars ]]--
local function CreateCVar(name, default, text)
	local cvar = CreateConVar(name, default, { FCVAR_DEMO, FCVAR_REPLICATED }, text)
	return function() return cvar:GetFloat() end
end

local function CreateCVarInt(name, default, text)
	local cvar = CreateConVar(name, default, { FCVAR_DEMO, FCVAR_REPLICATED }, text)
	return function() return cvar:GetInt() end
end

-- Temporary globals, will be removed in client.lua/server.lua.
ZAPC_MAX_HEALTH = CreateCVarInt('zapc_health', '5000', 'The maximum (and starting) health of an APC. Must be an integer.')
ZAPC_MAX_PASSENGERS = CreateCVarInt('zapc_passengers', '4', 'The amount of passengers the APC bay can hold.')
ZAPC_PRIMARY_RELOAD_TIME = CreateCVar('zapc_primary_reload_time', '1.5', 'The time it takes to reload the turret.')
ZAPC_SECONDARY_RELOAD_TIME = CreateCVar('zapc_secondary_reload_time', '2', 'The time it takes to reload a rocket.')