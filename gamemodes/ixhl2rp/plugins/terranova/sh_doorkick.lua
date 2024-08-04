--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.command.Add("Doorkick", {
	description = "Kopnij drzwi.",
	OnCheckAccess = function(self, client)
		if (!ix.faction.Get(client:Team()).allowKickDoor) then
			return false
		end

		local entity = client:GetEyeTrace().Entity
		if (!IsValid(entity) or !entity:IsDoor() or entity:GetNetVar("disabled")) then
			return false, "Nie patrzysz na drzwi!"
		end

		if (client:GetPos():DistToSqr(entity:GetPos()) > 10000) then
			return false, "Nie jesteś wystarczająco blisko!"
		end

		return true
	end,
	OnRun = function(self, client)
		local entity = client:GetEyeTrace().Entity
		if (IsValid(entity.ixLock)) then
			return "Nie możesz wyważyć zamka Kombinatu!"
		end

		local current = client:GetLocalVar("stm", 0)
		if (current > 90) then
			client:ConsumeStamina(15)
			client:ForceSequence("adoorkick", nil, 1.5)

			timer.Simple(0.5, function()
				entity:Fire("unlock")
				entity:Fire("open")
			end)
		else
			client:Notify("Nie masz wystarczającej kondycji!")
		end
    end
})