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

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_combinemonitor", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})

    ix.saveEnts:RegisterEntity("ix_combinemonitor_small", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})

    ix.saveEnts:RegisterEntity("ix_combinemonitor_tv", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false, owner = entity:GetNWInt("owner")}
		end,
        OnRestore = function(entity, data)
            entity:SetNWInt("owner", data.owner)
        end,
	})
end

function PLUGIN:PlayerMessageSend(speaker, chatType)
	if chatType == "broadcast" or chatType == "dispatch" then
		for _, ent in pairs(ents.GetAll()) do
			if ent:GetClass() != "ix_combinemonitor" and ent:GetClass() != "ix_combinemonitor_small" then continue end
			ent:EmitSound("ambient/alarms/warningbell1.wav", 90)
			ent:EmitSound("npc/overwatch/radiovoice/attention.wav", 70)
		end
	end
end

function PLUGIN:PlayerButtonDown( client, key )
    if IsFirstTimePredicted() then
        if key == KEY_LALT then
            local entity = client:GetEyeTraceNoCursor().Entity

			if !IsValid(entity) then
				return false
			end

			if (client:GetShootPos():Distance(entity:GetPos()) > 100) then
				return false
			end

			if entity:GetNWInt("owner") and client:GetCharacter():GetID() != entity:GetNWInt("owner") then
				return false
			end

            if (entity:GetClass() == "ix_combinemonitor_tv") then
                local pos = entity:GetPos()

                ix.item.Spawn("television", pos + Vector( 0, 0, 2 ), nil, entity:GetAngles())

                entity:Remove()
            end
        end
    end
end