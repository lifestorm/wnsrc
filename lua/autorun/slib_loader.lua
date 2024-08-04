--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local function slibInit()
    print("[slib] Loading")

    if SERVER then
        AddCSLuaFile("slib/sh_util.lua")
        include("slib/sv_storage.lua")
        include("slib/sh_util.lua")
    else
        include("slib/sh_util.lua")
    end
end

hook.Add("slib:loadBase", "slib.loadVGUI", function()
    slib.loadFolder("slib/vgui/", false, {{"slib/vgui/", "cl_sframe.lua"}})
end)

slibInit()