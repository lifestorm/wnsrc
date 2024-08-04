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
	description = "Foutre un coup de pied dans une porte.",
	OnCheckAccess = function(self, client)
		if (!ix.faction.Get(client:Team()).allowKickDoor) then
			return false
		end

		local entity = client:GetEyeTrace().Entity
		if (!IsValid(entity) or !entity:IsDoor() or entity:GetNetVar("disabled")) then
			return false, "Vous ne regardez pas une porte !"
		end

		if (client:GetPos():DistToSqr(entity:GetPos()) > 10000) then
			return false, "Tu n'es pas assez proche !"
		end

		return true
	end,
	OnRun = function(self, client)
		local entity = client:GetEyeTrace().Entity
		if (IsValid(entity.ixLock)) then
			return "Vous ne pouvez pas taper dans une porte avec une serrure du cartel !"
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
			client:Notify("Vous n'avez pas assez d'endurance !")
		end
    end
})