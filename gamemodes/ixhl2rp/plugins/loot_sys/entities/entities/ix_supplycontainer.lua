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
ENT.PrintName = "Supply Container"
ENT.Category = "[WN7] Lootable"
ENT.Spawnable = true
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

ENT.models = {"models/wn7new/advcrates/n7_supply_crate.mdl"}
ENT.acting = 1
ENT.canBeLooted = true
local PLUGIN = PLUGIN


if (SERVER) then
	function ENT:Initialize()
		self:SetModel(self.models[math.random(1, #self.models)])
		self:PhysicsInit(SOLID_VPHYSICS	)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.lootTable = ix.loot.tables["Supply"]
		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:Sleep()
			physObj:EnableMotion( false )
		end
		self:DropToFloor()

	end
	function ENT:Use( activator )
		if #player.GetAll() < ix.config.Get("PlayersToLoot", 8) then 
			activator:Notify("Server doesn't have enough players to unblock crate looting.")
			return
		end		
		if not self.canBeLooted then return activator:Notify("Someone already looted this container!") end
		local data = {act = self.acting, ent = self}
		netstream.Start(activator, "ixLootInteractStart", data)
	end
	function ENT:FinalizeLoot(character, shouldChance, noAddLoot)
		if not self.canBeLooted then return end

		self:ResetSequence("locker_open_seq")
		self:SetPlaybackRate(1)
		timer.Simple(2.6, function()
			if not IsValid(self) then return end
			self:EmitSound("items/ammocrate_close.wav")
			self:ResetSequence("locker_close_seq")
			self:SetPlaybackRate(1)
		end)
		local items = PLUGIN:CalculateLoot(self.lootTable, shouldChance, noAddLoot)
		if #items <= 1 then 
			self:EmitSound("physics/metal/metal_computer_impact_hard2.wav")
		else 
			self:EmitSound("items/ammocrate_close.wav")
		end
		for _, item in ipairs(items) do
			ix.item.Spawn(item, self:GetPos() + self:GetUp()*20 + self:GetForward()*20 + self:GetRight()*math.random(-20, 20), function(item, ent)
				timer.Create("Mark for destruct " .. ent:GetCreationID(), ix.config.Get("lootDelete", 10), 1, function()
					if ent:IsValid() then 
						ent:Remove()	
					end
				end)
			end)
		end
		self.canBeLooted = false

	end
	function ENT:Think()
		self:NextThink( CurTime() + 0.1 )
    	return true 
	end	 
else
	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Supply container")
		name:SizeToContents()

		local description = container:AddRow("Description")
		description:SetText("[E] for interaction.")
		description:SizeToContents()
	end
	function ENT:Draw()
		self:DrawModel()
	end
end

