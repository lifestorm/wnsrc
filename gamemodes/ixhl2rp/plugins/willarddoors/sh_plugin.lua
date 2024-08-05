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
	description = "Set the owner for the door you are looking at",
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
                local text = target:GetName().." now has keys to this door."
                client:NotifyLocalized(text)
            else
                client:NotifyLocalized("You are not looking at a valid door!")
            end
        end
	end
})

ix.command.Add("DoorRemoveOwner", {
	description = "Remove a specific owner for the door you are looking at",
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
                        local text = target:GetName().." no longer has keys to this door."
                        client:NotifyLocalized(text)
                        return
                    end
                end
                local text = target:GetName().." does not have keys to this door."
                client:NotifyLocalized(text)
            else
                client:NotifyLocalized("You are not looking at a valid door")
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
                local msg       = "No one has the keys to this door."
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
                    msg = "Currently loaded characters with access to this door: "
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
