--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "NPC Faction Relations"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Set relations between NPC's and factions."

PLUGIN.defaultRelations = PLUGIN.defaultRelations or {}

function PLUGIN:GetHookCallPriority(hook)
	if (hook == "OnPlayerCombineSuitChange") then
		return 900
	end
end

function PLUGIN:GetClientTeam(client)
    return client:GetNetVar("combineSuitType", 0) != 0 and client:GetNetVar("combineSuitType") or client:Team()
end

function PLUGIN:OnEntityCreated(entity)
    if (entity:IsNPC()) then
        local class = entity:GetClass()
        if (!self.defaultRelations[class]) then
            timer.Simple(1, function()
                if (!IsValid(entity)) then return end

                local players = player.GetAll()
                for _, v in ipairs(players) do
                    if (IsValid(v)) then
                        self.defaultRelations[class] = entity:Disposition(v)
                        break
                    end
                end

                for _, v in ipairs(players) do
                    local team = self:GetClientTeam(v)
                    local faction = ix.faction.Get(team)
                    if (faction and faction.npcRelations and faction.npcRelations[class]) then
                        entity:AddEntityRelationship(v, faction.npcRelations[class], 99)
                    end
                end
            end)
        else
            local players = player.GetAll()
            for _, v in ipairs(players) do
                local team = self:GetClientTeam(v)
                local faction = ix.faction.Get(team)
                if (faction and faction.npcRelations and faction.npcRelations[class]) then
                    entity:AddEntityRelationship(v, faction.npcRelations[class], 99)
                end
            end
        end
    end
end

function PLUGIN:PlayerInitialSpawn(client)
    local entities = ents.GetAll()
    for i = 1, #entities do
        if (entities[i]:IsNPC()) then
            self.defaultRelations[entities[i]:GetClass()] = entities[i]:Disposition(client)
        end
    end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
    local team = self:GetClientTeam(client)
    local faction = ix.faction.Get(team)

    local entities = ents.GetAll()
    for i = 1, #entities do
        if (entities[i]:IsNPC()) then
            local class = entities[i]:GetClass()
            if (faction.npcRelations and faction.npcRelations[class]) then
                entities[i]:AddEntityRelationship(client, faction.npcRelations[class], 99)
            elseif (self.defaultRelations[class]) then
                entities[i]:AddEntityRelationship(client, self.defaultRelations[class], 99)
            end
        end
    end
end

function PLUGIN:OnPlayerCombineSuitChange(client, bEquipped, bActive, suit, bLoadout)
    local team = self:GetClientTeam(client)
    local faction = ix.faction.Get(team)
    if (!faction) then return end

    local entities = ents.GetAll()
    for i = 1, #entities do
        if (entities[i]:IsNPC()) then
            local class = entities[i]:GetClass()
            if (faction.npcRelations and faction.npcRelations[class]) then
                entities[i]:AddEntityRelationship(client, faction.npcRelations[class], 99)
            elseif (self.defaultRelations[class]) then
                entities[i]:AddEntityRelationship(client, self.defaultRelations[class], 99)
            end
        end
    end
end