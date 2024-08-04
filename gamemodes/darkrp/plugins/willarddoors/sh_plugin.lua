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

PLUGIN.name = "Persistant Doors"
PLUGIN.author = "M!NT"
PLUGIN.description = "Allows a command for admins that allows a specific player to own a door (lock / unlock)."

ix.util.Include("sv_plugin.lua")

ix.command.Add("DoorAddOwner", {
	description = "Définir le propriétaire pour la porte que vous regardez",
	privilege = "DoorOwnership",
	adminOnly = true,
	arguments = {
		ix.type.character,
	},
	OnRun = function(self, client, target)
        if (target) then
            local targetDoor = client:GetEyeTrace().Entity
            if (IsValid(targetDoor) and targetDoor:IsDoor()) then
                target:SetOwnedDoors(targetDoor:EntIndex())
                local text = target:GetName().." a maintenant les clés de cette porte."
                client:NotifyLocalized(text)
            else
                client:NotifyLocalized("Vous ne regardez pas une porte valide!")
            end
        end
	end
})

ix.command.Add("DoorRemoveOwner", {
	description = "Supprimer un propriétaire spécifique pour la porte que vous regardez",
	privilege = "DoorOwnership",
	adminOnly = true,
	arguments = {
		ix.type.character,
	},
	OnRun = function(self, client, target)
        if (target) then
            local targetDoor = client:GetEyeTrace().Entity
            if (IsValid(targetDoor) and targetDoor:IsDoor()) then
                for k, v in pairs(target.vars.OwnedDoors) do
                    if (v == targetDoor:EntIndex()) then
                        table.remove(
                            target.vars.OwnedDoors,
                            k
                        )
                        local text = target:GetName().." n’a plus les clés de cette porte."
                        client:NotifyLocalized(text)
                        return
                    end
                end
                local text = target:GetName().." n’a pas les clés de cette porte."
                client:NotifyLocalized(text)
            else
                client:NotifyLocalized("Vous ne regardez pas une porte valide")
            end
        end
	end
})

ix.command.Add("DoorPrintOwners", {
	description = "Prints the owners of this door into your chat.",
	privilege = "DoorOwnership",
	adminOnly = true,
	OnRun = function(self, client, target)
        if (target) then
            local targetDoor = client:GetEyeTrace().Entity
            if (IsValid(targetDoor) and targetDoor:IsDoor()) then
                local msg       = "Personne n’a les clés de cette porte."
                local owners    = {}
                local targetIdx = targetDoor:EntIndex()
                for _, ply in pairs(player.GetAll()) do
                    local char = ply:GetCharacter()
                    if (char) then
                        for _, idx in pairs(char:GetOwnedDoors()) do
                            if (idx == targetIdx) then
                                table.insert(
                                    owners,
                                    #owners + 1,
                                    char:GetName()
                                )
                                break
                            end
                        end
                    end
                end
                if (#owners > 0) then
                    msg = "Personnage actuellement chargés avec accès à cette porte: "
                    for _, name in pairs(owners) do
                        msg = msg..name.." "
                    end
                end
                net.Start("OnDoorPrintOwners")
                    net.WriteString(msg)
                net.Send(client)
            end
        end
	end
})

do

    if (CLIENT) then
        net.Receive("OnDoorPrintOwners", function()
            local text = net.ReadString()
            chat.AddText(Color(255,255,255), text)
        end)
    end

end
