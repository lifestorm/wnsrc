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
ENT.PrintName = "Basic Container"
ENT.Category = "[WN7] Lootable"
ENT.Spawnable = true
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

ENT.acting = 1
local PLUGIN = PLUGIN


if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_junk/wood_crate001a_damaged.mdl")
		self:PhysicsInit(SOLID_VPHYSICS	)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:PrecacheGibs()
		self.lootTable = ix.loot.tables["Basic"]
		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:Sleep() 
			physObj:EnableMotion( false )
		end
		//self:DropToFloor()

	end
	function ENT:Use( activator )
		if #player.GetAll() < ix.config.Get("PlayersToLoot", 8) then 
			activator:Notify("Server doesn't have enough players to unblock crate looting.")
			return
		end
		local data = {act = self.acting, ent = self}
		netstream.Start(activator, "ixLootInteractStart", data)
	end
	function ENT:FinalizeLoot(character, shouldChance, noAddLoot)
		self:GibBreakServer( self:GetUp() * 100 ) 
		self:EmitSound("physics/wood/wood_plank_break1.wav")
		local items = PLUGIN:CalculateLoot(self.lootTable, shouldChance, noAddLoot)
		for _, item in ipairs(items) do
			ix.item.Spawn(item, self:GetPos() + self:GetRight()*math.random(-20, 20), function(item, ent)
				timer.Create("Mark for destruct " .. ent:GetCreationID(), ix.config.Get("lootDelete", 10), 1, function()
					if ent:IsValid() then 
						ent:Remove()	
					end
				end)
			end)
		end
		self:Remove()

	end
	function ENT:Think()
		self:NextThink( CurTime() + 0.1 )
    	return true 
	end	 
else
	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Wooden crate")
		name:SizeToContents()

		local description = container:AddRow("Description")
		description:SetText("[E] for interaction.")
		description:SizeToContents()
	end	
	function ENT:Draw()
		self:DrawModel()
	end
end

