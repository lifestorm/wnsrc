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

PLUGIN.name = "Inebriation"
PLUGIN.author = "M!NT"
PLUGIN.description = "Adds a more immersive system for drinking alchohol."

ix.char.RegisterVar("inebriation", {
	field = "inebriation",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true
})

CAMI.RegisterPrivilege({
	Name = "Helix - Inebriation Control",
	MinAccess = "admin"
})

ix.command.Add("SetInebriation", {
	description = "Set how drunk a character is (0-100).",
	arguments = {
		ix.type.character,
        ix.type.number
	},
    privilege = "Inebriation Control",
	OnRun = function(self, client, character, inebriationPercent)
        if (inebriationPercent < 0 or inebriationPercent > 100) then
            return "Invalid percentage."
        end

        if (!ix.inebriation.allowedFactions[character:GetFaction()]) then
            return "Faction not allowed to be drunk."
        end

        character:GetPlayer():SetNetVar("inebriation", inebriationPercent)
        character:SetInebriation(inebriationPercent)
    end
})

ix.config.Add("inebriationDecay", 0.2, "How much inebriation decays per interval.", nil, {
    data = {min = 0, max = 5, decimals = 3}
})

ix.inebriation = {}
ix.inebriation.types = {
    ["SOBER"] = {
        name = "Sober",
        description = "You're completely sober.",
        threshold = 0
    },
    ["SLIGHTLY_DRUNK"] = {
        name = "Slightly Drunk",
        description = "You're feeling a little tipsy.",
        threshold = 10
    },
    ["DRUNK"] = {
        name = "Drunk",
        description = "You're feeling drunk.",
        threshold = 40
    },
    ["VERY_DRUNK"] = {
        name = "Very Drunk",
        description = "You're feeling very drunk.",
        threshold = 70
    },
    ["WASTED"] = {
        name = "Wasted",
        description = "You're wasted drunk.",
        threshold = 90
    }
}

ix.inebriation.allowedFactions = {
    FACTION_ADMIN,
    FACTION_BMDFLAGSYSTEM,
    FACTION_CITIZEN,
    FACTION_CP,
    FACTION_MOE,
    FACTION_MCP,
    FACTION_MEDICAL,
    FACTION_RESISTANCE,
    FACTION_WORKERS
}

ix.inebriation.grades = {
    ["LOW"] = {
        appendText = "This is a low quality drink.",
        damage = 15
    },
    ["MEDIUM"] = {
        appendText = "This is a medium quality drink.",
        damage = 5
    },
    ["HIGH"] = {
        appendText = "This is a high quality drink.",
        damage = 0
    }
}

function ix.inebriation:GetType(inebriation)
    if (inebriation < 10) then
        return self.types.SOBER
    elseif (inebriation < 40) then
        return self.types.SLIGHTLY_DRUNK
    elseif (inebriation < 70) then
        return self.types.DRUNK
    elseif (inebriation < 90) then
        return self.types.VERY_DRUNK
    else
        return self.types.WASTED
    end
end

do
    local PLAYER = FindMetaTable("Player")

    function PLAYER:GetInebriation()
        return self:GetNetVar("inebriation", 0)
    end

    function PLAYER:IsDrunk()
        return self:GetInebriation() > 39
    end
end

-- unreliable
function PLUGIN:SetupMove(ply, mv, cmd)
    if (ply:GetNetVar("inebriation", 0) < 10) then
        return
    end

    if (ply:GetMoveType() == MOVETYPE_FLY) then
        return
    end

    local isWalking = cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_BACK) or cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT)
    local isRunning = cmd:KeyDown(IN_SPEED) or cmd:KeyDown(IN_RUN)
    local fElastic  = math.ease.InOutElastic(math.abs(math.sin(CurTime() / 6)), 2, 3)
    local fElastic2 = math.ease.InOutElastic(math.abs(math.sin(CurTime() / 4)), 2, 4)
    local fSin = math.sin(CurTime() / fElastic)
    local ineb = ply:GetNetVar("inebriation", 0) / 100

    local maxReduce = 0
    local newSpeed = 0
    local inBack = cmd:KeyDown(IN_BACK) and -1 or 1
    if (isWalking and !isRunning) then
        maxReduce = ply:GetWalkSpeed() * 0.6 * ineb
        newSpeed = (ply:GetWalkSpeed() - maxReduce) + (maxReduce * fSin)
    elseif (isRunning) then
        maxReduce = ply:GetRunSpeed() * 0.6 * ineb
        newSpeed = (ply:GetRunSpeed() - maxReduce) + (maxReduce * fSin)
    end

    mv:SetForwardSpeed(inBack * newSpeed)
    cmd:SetForwardMove(inBack * newSpeed)

    if (isWalking or isRunning) then
        local fCos = math.cos(CurTime() / math.Clamp(fElastic2, 1, 4))
        local sideSpeed = cmd:GetSideMove()
        if (sideSpeed == 0) then
            -- need to give them some side speed anyways -_-
            sideSpeed = (fCos < 0 and -1 * ply:GetWalkSpeed() or ply:GetWalkSpeed()) * ineb
        end
        local sideStumble = sideSpeed + (fCos * 100 * ineb)

        if (math.abs(sideStumble) > 30) then
            mv:SetSideSpeed(sideStumble)
            cmd:SetSideMove(sideStumble)
        end
    end
end

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")