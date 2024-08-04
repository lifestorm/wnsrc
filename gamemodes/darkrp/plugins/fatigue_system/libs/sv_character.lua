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

ix.char.RegisterVar("energy", {
	field = "energy",
	fieldType = ix.type.number,
	default = 100,
	isLocal = true,
	bNoDisplay = true,
	OnSet = function(self, newEnergy, bNoNetwork)
		newEnergy = newEnergy and math.max(newEnergy, 0) or 0

		if (self.vars.energy == newEnergy) then
			return false
		end

		self.vars.energy = newEnergy

		if (!bNoNetwork) then
			net.Start("ixCharacterVarChanged")
				net.WriteUInt(self:GetID(), 32)
				net.WriteString("energy")
				net.WriteType(self.vars.energy)
			net.Send(self:GetPlayer())
		end

		--hook.Run("CharacterVarChanged", self, key, oldVar, value)

		return true
	end
})

do
	local charMeta = ix.meta.character

	function charMeta:ShiftEnergy(energyShift, maxBonusEnergy, bNoNetwork)
		maxBonusEnergy = maxBonusEnergy or 0
		local newEnergy = self:GetEnergy()
		local maxEnergy = 100 + maxBonusEnergy

		if (energyShift > 0) then
			if (newEnergy >= maxEnergy) then
				return false
			end

			newEnergy = math.min(newEnergy + energyShift, maxEnergy)
		else
			newEnergy = newEnergy + energyShift
		end
	
		return self:SetEnergy(newEnergy, energyBonusMax, bNoNetwork)
	end
end
