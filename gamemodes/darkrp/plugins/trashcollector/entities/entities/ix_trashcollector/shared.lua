--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName		= "Trash Collector"
ENT.Author			= "Fruity"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= "Fruitybooty"

ENT.Category = "HL2 RP"

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

ENT.buttons = {}
ENT.disAllowedJunk = {
    "junk_pc_monitor",
    "junk_frame",
    "trash_biolock",
    "junk_cardboard"
}

ENT.Displays = {
	[1] = {"WAITING FOR TRASH", Color( 255, 255, 180 )},
	[2] = {"IN PROGRESS", Color( 255, 255, 180 )},
	[3] = {"SELECTING JUNK", Color( 180, 255, 180 )},
	[4] = {"SUCCESS", Color( 0, 255, 0 )}
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
	self:NetworkVar("Bool", 0, "Used")
end

function ENT:GetNearestButton(client)
	client = client or (CLIENT and LocalPlayer())

	if (self.buttons) then
		if (SERVER) then
			local position = self:GetPos()
			local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

			self.buttons[1] = position + f*-45.5 + r*20 + u*45
			self.buttons[2] = position + f*-45.5 + r*20 + u*38
		end

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		local hitPos = trace.HitPos

		if (hitPos) then
			for k, v in pairs(self.buttons) do
				if (v:Distance(hitPos) <= 2) then
					return k
				end
			end
		end
	end
end