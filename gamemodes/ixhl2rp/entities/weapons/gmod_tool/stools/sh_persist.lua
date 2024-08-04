--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


TOOL.Category = "HL2RP Staff QoL"
TOOL.Name = "Persist"
TOOL.RequiresTraceHit = true

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}

local function GetRealModel(entity)
	return entity:GetClass() == "prop_effect" and entity.AttachedEntity:GetModel() or entity:GetModel()
end

function TOOL:LeftClick( trace )
	if (SERVER) then
		if !CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands") then return false end

		local entity = trace.Entity
		if !entity or entity and !IsValid(entity) then return end
		if entity:IsPlayer() or entity:IsVehicle() or entity.bNoPersist then return end
		if !self.GetOwner then return end
		if !self:GetOwner() then return end
		if !IsValid(self:GetOwner()) then return end
		if !ix.plugin.list then return end
		if !ix.plugin.list["persistence"] then return end
		if !ix.plugin.list["persistence"].stored then return end

		local lampCount = 0

		for _, v in pairs(ix.plugin.list["persistence"].stored) do
			if IsValid(v) and v:GetClass() == "gmod_lamp" then
				lampCount = lampCount + 1
			end
		end

		if !entity:GetNetVar("Persistent") then
			if entity:GetClass() == "gmod_lamp" and lampCount >= ix.config.Get("maxLamps", 1) then
				return self:GetOwner():Notify("Max persisted lamps reached.")
			end

			ix.plugin.list["persistence"].stored[#ix.plugin.list["persistence"].stored + 1] = entity

			entity:SetNetVar("Persistent", true)
			ix.saveEnts:SaveEntity(entity)

			ix.log.Add(self:GetOwner(), "persist", GetRealModel(entity), true)
			self:GetOwner():Notify("You persisted this entity.")
		else
			for k, v in ipairs(ix.plugin.list["persistence"].stored) do
				if (v == entity) then
					table.remove(ix.plugin.list["persistence"].stored, k)

					break
				end
			end

			entity:SetNetVar("Persistent", false)
			ix.saveEnts:DeleteEntity(entity)

			ix.log.Add(self:GetOwner(), "persist", GetRealModel(entity), false)
			self:GetOwner():Notify("You unpersisted this entity.")
		end
	end
end

if CLIENT then
	language.Add( "Tool.sh_persist.name", "Persist" )
	language.Add( "Tool.sh_persist.desc", "Same as persist in context menu" )
	language.Add( "Tool.sh_persist.left", "Primary: Persist/Unpersist" )
	language.Add( "Tool.sh_persist.right", "Nothing." )
	language.Add( "Tool.sh_persist.reload", "Nothing." )
end