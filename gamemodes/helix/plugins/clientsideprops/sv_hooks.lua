--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

function PLUGIN:LoadData()
	self.clientProps = self:GetData() or {}
end

function PLUGIN:SaveData()
	self:SetData(self.clientProps)
end

net.Receive("ixClientProps.RecreateProp", function(_, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage Clientside Props")) then return end

	local position = net.ReadVector()

	for k, propData in ipairs(PLUGIN.clientProps) do
		if (!propData.position:IsEqualTol(position, 0.1)) then continue end

		local entity = ents.Create("prop_physics")
		entity:SetModel(propData.model)
		entity:SetPos(position)
		entity:SetAngles(propData.angles)
		entity:SetSkin(propData.skin)
		entity:SetColor(propData.color)
		entity:SetRenderMode(RENDERMODE_TRANSCOLOR)
		entity:SetMaterial(propData.material)

		entity:Spawn()

		local physicsObject = entity:GetPhysicsObject()

		if (IsValid(physicsObject)) then
			physicsObject:EnableMotion(false)
		end

		table.remove(PLUGIN.clientProps, k)

		net.Start("ixClientProps.RecreateProp")
			net.WriteVector(position)
		net.Broadcast()

		break
	end
end)

net.Receive("ixClientProps.RequestProps", function(_, client)
	express.Send("ixClientProps.RequestProps", PLUGIN.clientProps, client)
end)
