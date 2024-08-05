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
ENT.PrintName = "Combine Container"
ENT.Category = "[WN7] Lootable"
ENT.Spawnable = true
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

ENT.models = {"models/wn7new/advcrates/n7_crate.mdl"}
ENT.acting = 3
ENT.canBeLooted = true
ENT.lootKey = "cmbkey"

local PLUGIN = PLUGIN


if (SERVER) then
	function ENT:Initialize()
		self:SetModel(self.models[math.random(1, #self.models)])
		self:PhysicsInit(SOLID_VPHYSICS	)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.lootTable = ix.loot.tables["CMB"]
		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:Sleep()
			physObj:EnableMotion( false )
		end
		self:DropToFloor()

	end
	function ENT:Use( activator )
		if #player.GetAll() < ix.config.Get("PlayersToLoot", 8) then 
			activator:Notify("Na serwerze nie ma wystarczającej liczby graczy, aby odblokować lootowanie skrzyń.")
			return
		end
		if not self.canBeLooted then return activator:Notify("Ktoś już złupił ten pojemnik!") end
		local data = {act = self.acting, ent = self}
		netstream.Start(activator, "ixLootInteractStart", data)
	end
	function ENT:FinalizeLoot(character, shouldChance, noAddLoot)
		if not self.canBeLooted then return end

		self:ResetSequence("locker_open_seq")
		self:SetPlaybackRate(1)
		self:EmitSound("buttons/button19.wav")
		timer.Simple(2.6, function()
			if not IsValid(self) then return end
			self:EmitSound("items/ammocrate_close.wav")
			self:ResetSequence("locker_close_seq")
			self:SetPlaybackRate(1)
		end)
		local items = PLUGIN:CalculateLoot(self.lootTable, shouldChance, noAddLoot)
		if #items <= 1 then 
			self:EmitSound("physics/metal/metal_computer_impact_hard2.wav")
		end
		for _, item in ipairs(items) do
			ix.item.Spawn(item, self:GetPos() + self:GetUp()*20 + self:GetForward()*20 + self:GetRight()*math.random(-20, 20), function(item, ent)
				timer.Create("Oznaczenie do zniszczenia " .. ent:GetCreationID(), ix.config.Get("lootDelete", 10), 1, function()
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
		name:SetText("Skrzynia CMB")
		name:SizeToContents()

		local description = container:AddRow("Description")
		description:SetText("[E] w celu interakcji.")
		description:SizeToContents()
	end	
	local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")
	function ENT:Draw()
		self:DrawModel()
		if self:GetSequenceName(self:GetSequence()) == "locker_open_seq" then return end
		local color = Color(0, 100, 255, 180)
		local position = self:GetPos() + self:GetUp() * 12 + self:GetForward() * 13.5
		render.SetMaterial(glowMaterial)
		render.DrawSprite(position, 10, 10, color)
	end
end
