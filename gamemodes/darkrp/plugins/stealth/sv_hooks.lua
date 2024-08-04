--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:PlayerFootstep(client, position, foot, soundName, volume)
	if (client:KeyDown(IN_WALK) or client:KeyDown(IN_DUCK)) then
		return true
	end
end

function PLUGIN:AcceptInput(entity, input, activator, caller, value)
    if (input == "Use" and entity:IsDoor() and (activator:KeyDown(IN_WALK) or activator:KeyDown(IN_DUCK))) then
        entity:StealthOpenDoor()

        if (entity:GetInternalVariable("slavename")) then
            for _, slave in pairs(ents.FindByName(entity:GetInternalVariable("slavename"))) do
                slave:StealthOpenDoor()
            end
        end

        for _, slave in pairs(ents.FindByName(entity:GetName())) do
            slave:StealthOpenDoor()
        end
    end
end

function PLUGIN:EntityEmitSound(data)
    if !data.Entity or data.Entity and !IsValid(data.Entity) then return end
    
    if (data.Entity:IsDoor() and data.Entity.stealthOpen) then
        data.Volume = data.Volume * 0.05

        return true
    end
end
