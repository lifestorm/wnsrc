--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]



AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

function ENT:Use(client)
	if client.CantPlace then
		client:NotifyLocalized("You need to wait before you can use this!")
		return false
	end

	client.CantPlace = true

	timer.Simple(3, function()
		if client then
			client.CantPlace = false
		end
	end)

    if self:GetEnabled() then
        self:SetEnabled(false)
    else
        self:SetEnabled(true)
    end

    self:EmitSound("buttons/button18.wav")
end

function ENT:OnInitialize()
    self:SetEnabled(true)
end