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

ix.teleporters = ix.teleporters or {}

ix.saveEnts:RegisterEntity("ix_teleporter", true, true, true, {
    OnSave = function(entity, data)
        data.ID = entity.ID
        data.Mate = entity.Mate
        data.EntModel = entity.EntModel and entity.EntModel or entity.Model
        data.WarpSound = entity.WarpSound
        data.UniqueName = #entity.UniqueName > 1 and entity.UniqueName or "Default"
        data.WarpPos = isvector(entity.WarpPos) and entity.WarpPos or nil
        data.WarpAngles = isangle(entity.WarpAngles) and entity.WarpAngles or nil
    end,
    OnRestore = function(entity, data)
        entity.ID = data.ID
        entity.Mate = data.Mate
        entity.EntModel = data.EntModel
        entity.WarpSound = data.WarpSound
        entity.UniqueName = data.UniqueName
        entity.WarpPos = data.WarpPos
        entity.WarpAngles = data.WarpAngles

        ix.teleporters:ReinitializeModel(entity, entity.EntModel and entity.EntModel or entity.Model)
    end
})

netstream.Hook("ixTeleportersAssignMates", function(ply, ID1, ID2)
    if (!CAMI.PlayerHasAccess(ply, "Helix - Manage Teleporters")) then
        return
    end

    ix.teleporters:TeleporterFindByID(ID1).Mate = ID2
    ix.teleporters:TeleporterFindByID(ID2).Mate = ID1
end)

netstream.Hook("ixTeleportersGetData", function(ply)
    if (!CAMI.PlayerHasAccess(ply, "Helix - Manage Teleporters")) then
        return
    end

    netstream.Start(ply, "ixTeleportersSendData", ix.teleporters:GetTeleportersData())
end)

function PLUGIN:SetupPlayerVisibility(client)
    for _, v in pairs(ents.FindByClass("ix_teleporter")) do
        if (v:IsValid()) then
            AddOriginToPVS(v:GetPos())
        end
    end
end