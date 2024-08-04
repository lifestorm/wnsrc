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
TOOL.Name = "NPC Spawner Editor"
TOOL.RequiresTraceHit = true

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}
function TOOL:GetPlayerBoundsTrace()
	local client = self:GetOwner()

	return util.TraceLine({
		start = client:GetShootPos(),
		endpos = client:GetShootPos() + client:GetForward() * 96,
		filter = client
	})
end
function TOOL:LeftClick( trace )
	
	
	if (SERVER) then
		if !CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands") then return false end
		
		local entity = trace.Entity
		if !entity or entity and !IsValid(entity) then return end
		if !self.GetOwner then return end
		if !self:GetOwner() then return end
		if !IsValid(self:GetOwner()) then return end
		if entity:GetClass() != "ix_npcspawner" then return end	
		entity:Use(self:GetOwner())
	end
end
function TOOL:RightClick( trace )
	local entity = trace.Entity
	local client = self:GetOwner()
	if !entity or entity and !IsValid(entity) then
		client.npcEditStart = nil 
		client.npcEnt = nil 
		return 
	end
	if !self.GetOwner then return end
	if !self:GetOwner() then return end
	if !IsValid(self:GetOwner()) then return end
	if entity:GetClass() != "ix_npcspawner" then return end	
	if client.npcEditStart then
		client.npcEditStart = nil 
		client.npcEnt = nil
	else 
		client.npcEditStart = entity:GetPos() + (entity:GetForward() * -60 + entity:GetRight()*-40 + entity:GetUp()*128)
		client.npcEnt = entity
	end
end
function TOOL:Reload(trace)
	local client = self:GetOwner()
	if !CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands") then return false end
		if !self.GetOwner then return end
		if !self:GetOwner() then return end
		if !IsValid(self:GetOwner()) then return end
		if !client.npcEditStart or !client.npcEnt then return end
		local tr = util.TraceLine({
			start = client:GetShootPos(),
			endpos = client:GetShootPos() + client:GetForward() * 96,
			filter = client
		})
		client.npcEnt:SetSpawnPosStart(client.npcEditStart)
		client.npcEnt:SetSpawnPosEnd(tr.HitPos)

	client.npcEditStart = nil 
	client.npcEnt = nil 
end 
if CLIENT then
	hook.Add("PostDrawTranslucentRenderables", "NPCSpawnEdit", function(bDepth, bSkybox)
		if ( bSkybox ) then return end
		if LocalPlayer().npcEditStart then 
			local tr = util.TraceLine({
				start = LocalPlayer():GetShootPos(),
				endpos = LocalPlayer():GetShootPos() + LocalPlayer():GetForward() * 96,
				filter = LocalPlayer()
			})
			local center, min, max = LocalPlayer().npcEnt:SpawnAreaPosition(LocalPlayer().npcEditStart, tr.HitPos)
			local color = Color(255, 255, 255, 255)

			render.DrawWireframeBox(center, angle_zero, min, max, color)	
		end	
	end)


	language.Add( "Tool.sh_npcspawnedit.name", "NPC Spawner Configurator" )
	language.Add( "Tool.sh_npcspawnedit.desc", "You can edit NPC spawner entities with it." )
	language.Add( "Tool.sh_npcspawnedit.left", "Open spawner menu" )
	language.Add( "Tool.sh_npcspawnedit.right", "Edit spawner area bounds. Click again to stop changing bounds." )
	language.Add( "Tool.sh_npcspawnedit.reload", "Save your area bound changes." )
end