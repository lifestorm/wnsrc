--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()
--[[-------------------------------------------------------------------------
TODO: PLAY ANIMATION WHEN DEPLOYING SUPPORT
---------------------------------------------------------------------------]]
ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.PrintName = "Broke (Electricity)"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:SetNoDraw(true)
		self:SetUseType(SIMPLE_USE)
		self.health = 200
		self:SetNetVar("destroyed", true)
	end

    function ENT:Think()
        local curTime = CurTime()

        if self:GetNetVar("destroyed", false) == true then
			if !self.nextSpark or self.nextSpark <= curTime then
				if (!IsValid(self.spark)) then
					self.spark = ents.Create("env_spark")
				end
				self.spark:SetPos(self:GetPos() + Vector(0, 10, 0))
				self.spark:Fire("SparkOnce")

				self.nextSpark = curTime + 4
			end
        end
    end

	function ENT:Use(user)
		local item = user:GetCharacter():GetInventory():HasItem("tool_toolkit")
		if self:GetNetVar("destroyed", false) == true and !item then
			user:Notify("You need a toolkit to repair the damage") -- message when dont work and you dont have item
			return false
		else
			if item and self:GetNetVar("destroyed", false) == true then
				user:Freeze(true)
				user:SetAction("Repairing...", 12, function() -- line with text when you repair it
					item = user:GetCharacter():GetInventory():HasItem("tool_toolkit")

					if (item) then
						if (item.isTool) then
							item:DamageDurability(1)
						end

						self:SetNetVar("destroyed", false)
						user:Freeze(false)
						self.health = 200
						self:EmitSound("physics/cardboard/cardboard_box_impact_hard7.wav", 100, 75)
						self:Remove()
						user:Notify("Successfully fixed the electrical damage") -- message when you finish the job
					end
				end)
			end
		end
	end
end
