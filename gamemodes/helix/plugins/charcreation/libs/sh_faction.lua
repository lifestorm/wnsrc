--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local CITIZEN_MODELS = {
	"models/humans/group01/male_01.mdl",
	"models/humans/group01/male_02.mdl",
	"models/humans/group01/male_04.mdl",
	"models/humans/group01/male_05.mdl",
	"models/humans/group01/male_06.mdl",
	"models/humans/group01/male_07.mdl",
	"models/humans/group01/male_08.mdl",
	"models/humans/group01/male_09.mdl",
	"models/humans/group02/male_01.mdl",
	"models/humans/group02/male_03.mdl",
	"models/humans/group02/male_05.mdl",
	"models/humans/group02/male_07.mdl",
	"models/humans/group02/male_09.mdl",
	"models/humans/group01/female_01.mdl",
	"models/humans/group01/female_02.mdl",
	"models/humans/group01/female_03.mdl",
	"models/humans/group01/female_06.mdl",
	"models/humans/group01/female_07.mdl",
	"models/humans/group02/female_01.mdl",
	"models/humans/group02/female_03.mdl",
	"models/humans/group02/female_06.mdl",
	"models/humans/group01/female_04.mdl"
}

--- Loads factions from a directory.
-- @realm shared
-- @string directory The path to the factions files.
function ix.faction.LoadFromDir(directory)
	for _, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
		local niceName = v:sub(4, -5)

		FACTION = ix.faction.teams[niceName] or {index = table.Count(ix.faction.teams) + 1, isDefault = false}
			if (PLUGIN) then
				FACTION.plugin = PLUGIN.uniqueID
			end

			ix.util.Include(directory.."/"..v, "shared")

			if (!FACTION.name) then
				FACTION.name = "Unknown"
				ErrorNoHalt("Faction '"..niceName.."' is missing a name. You need to add a FACTION.name = \"Name\"\n")
			end

			if (!FACTION.description) then
				FACTION.description = "noDesc"
				ErrorNoHalt("Faction '"..niceName.."' is missing a description. You need to add a FACTION.description = \"Description\"\n")
			end

			if (!FACTION.color) then
				FACTION.color = Color(150, 150, 150)
				ErrorNoHalt("Faction '"..niceName.."' is missing a color. You need to add FACTION.color = Color(1, 2, 3)\n")
			end

			team.SetUp(FACTION.index, FACTION.name or "Unknown", FACTION.color or Color(125, 125, 125))

			FACTION.models = FACTION.models or CITIZEN_MODELS
			FACTION.uniqueID = FACTION.uniqueID or niceName

			for _, v2 in pairs(FACTION.models) do
				if (isstring(v2)) then
					util.PrecacheModel(v2)
				elseif (istable(v2)) then
					util.PrecacheModel(v2[1])
				end
			end

			if (!FACTION.GetModels) then
				function FACTION:GetModels(client)
					return self.models
				end
			end

			-- GENDERS
			if (!FACTION.GetModelsMale) then
				function FACTION:GetModelsMale(client)
					return self.models.male
				end
			end

			if (!FACTION.GetModelsFemale) then
				function FACTION:GetModelsFemale(client)
					return self.models.female
				end
			end

			if (!FACTION.GetNoGender) then
				function FACTION:GetNoGender(client)
					return self.noGender
				end
			end

			if (!FACTION.GetNoGenetics) then
				function FACTION:GetNoGenetics(client)
					return self.noGenetics
				end
			end

			if (!FACTION.GetNoAppearances) then
				function FACTION:GetNoAppearances(client)
					return self.noAppearances
				end
			end

			if (!FACTION.GetReadOptionDisabled) then
				function FACTION:GetReadOptionDisabled(client)
					return self.ReadOptionDisabled
				end
			end

			if (!FACTION.GetNoBackground) then
				function FACTION:GetNoBackground(client)
					return self.noBackground
				end
			end

			ix.faction.indices[FACTION.index] = FACTION
			ix.faction.teams[niceName] = FACTION
		FACTION = nil
	end
end

ix.command.Add("PlyWhitelist", {
	description = "@cmdPlyWhitelist",
	privilege = "Manage Character Whitelist",
	superAdminOnly = true,
	arguments = {
		ix.type.player,
		ix.type.text
	},
	OnRun = function(self, client, target, name)
		if (name == "") then
			return "@invalidArg", 2
		end

		local faction = ix.faction.teams[name]

		if (!faction) then
			for _, v in ipairs(ix.faction.indices) do
				if (ix.util.StringMatches(L(v.name, client), name) or ix.util.StringMatches(v.uniqueID, name)) then
					faction = v

					break
				end
			end
		end

		if (faction) then
			local result, text = hook.Run("CanWhitelistPlayer", target, faction)
			if (result == false) then
				return "@"..(text or "invalidFaction")
			end

			if (target:SetWhitelisted(faction.index, true)) then
				if faction.OnWhitelist then
					faction:OnWhitelist(target)
				end

				for _, v in ipairs(player.GetAll()) do
					if (self:OnCheckAccess(v) or v == target) then
						v:NotifyLocalized("whitelist", client:GetName(), target:GetName(), L(faction.name, v))
					end
				end
			end
		else
			return "@invalidFaction"
		end
	end
})