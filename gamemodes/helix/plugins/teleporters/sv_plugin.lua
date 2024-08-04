--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.teleporters = ix.teleporters or {}

function  ix.teleporters:CheckPermissions(ply)
	if (!CAMI.PlayerHasAccess(ply, "Helix - Manage Teleporters", nil)) then
        return false
    end

	return true
end

function ix.teleporters:SetEntModel(entity, strModel)
    if (!entity or !strModel or entity and !IsValid(entity) or strModel and IsUselessModel(strModel)) then
        return
    end

    if (isentity(entity) and entity:GetClass() == "ix_teleporter") then
        entity:SetModel(strModel)
        entity.EntModel = strModel

        self:ReinitializeModel(entity, strModel)
    end
end

function ix.teleporters:SetWarpPos(ID, hitPos)
    local teleporter = self:TeleporterFindByID(ID)

    if (teleporter and isentity(teleporter) and IsValid(teleporter)) then
        teleporter.WarpPos = hitPos
    end
end

function ix.teleporters:SetWarpAngles(ID, angles)
    local teleporter = self:TeleporterFindByID(ID)

    if (teleporter and isentity(teleporter) and IsValid(teleporter)) then
        teleporter.WarpAngles = angles
    end
end

function ix.teleporters:GetTeleportersData()
    local data = {}

    for _, v in ipairs(ents.FindByClass("ix_teleporter")) do
        data[#data + 1] = {
            name = v.UniqueName,
            id = v.ID,
            pos = v:GetPos(),
            angles = v:GetAngles(),
            mate = v.Mate,
            entModel = v.EntModel,
            warpSound = v.WarpSound,
            warpPos = v.WarpPos,
            warpAngles = v.WarpAngles,
            entIndex = v:EntIndex()
        }

        if (v.Mate and !self:TeleporterFindByID(v.Mate)) then
            v.Mate = nil
        end
    end

    return data
end

function ix.teleporters:GetID(caller, entity)
    if (caller and IsValid(caller) and entity and isentity(entity) and entity:GetClass() == "ix_teleporter") then
        caller:Notify(entity.ID)
    end
end

function ix.teleporters:IsDefaultTeleporter(entity)
   if (entity and isentity(entity) and entity:GetClass() == "ix_teleporter") then
        if (!entity.Mate) then
            return true
        end

        return false
   end
end

function ix.teleporters:IsMateValid(ID)
    local teleporter = self:TeleporterFindByID(ID)

    if (teleporter and teleporter.Mate) then
        return true
    end

    return false
end

function ix.teleporters:ReinitializeModel(entity, model) -- This will assure that bounds of model are reinitialized correctly to allow full free movement of the entity
    if (!entity or !model or model and #model == 0) then
        ErrorNoHalt("Attempted to reinitialize teleporter with missing arguments.")

        return
    end

    if (!entity or entity and !IsValid(entity)) then
        ErrorNoHalt("Attempted to reinitialize teleporter with invalid player argument.")

        return
    end

    entity:SetModel(model)
    entity:PhysicsInit(SOLID_VPHYSICS)
    entity:SetMoveType(MOVETYPE_VPHYSICS)
    entity:SetSolid(SOLID_VPHYSICS)

    local phys = entity:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:EnableMotion(false)
        phys:Wake()
    end
end

function ix.teleporters:TeleporterFindByID(ID)
    if (!ID) then
        ErrorNoHalt("Attempted to find teleporter with missing ID argument")

        return
    end

    for _, v in ipairs(ents.FindByClass("ix_teleporter")) do
        if (v.ID == ID) then
            return v
        end
    end

    return false
end