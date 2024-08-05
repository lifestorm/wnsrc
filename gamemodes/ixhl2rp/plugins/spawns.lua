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

PLUGIN.name = "Spawns"
PLUGIN.description = "Spawn points for factions and classes."
PLUGIN.author = "Chessnut, Fruity"
PLUGIN.spawns = PLUGIN.spawns or {}
PLUGIN.backgrounds = {"relocated citizen", "local citizen", "supporter citizen", "outcast", "biotic", "collaborator", "liberated", "free", "worker", "medic"}

ix.lang.AddTable("english", {
	optEspShowSpawns = "Show Spawn ESP",
	optdEspShowSpawns = "Show spawn positions in the admin ESP."
})

ix.lang.AddTable("spanish", {
	optEspShowSpawns = "Mostrar ESP de Spawn",
	optdEspShowSpawns = "Muestra las posiciones de reaparición en el Admin ESP."
})

function PLUGIN:PlayerLoadout(client)
	local character = client:GetCharacter()

	if (self.spawns and !table.IsEmpty(self.spawns) and character) then
		local background = character:GetBackground() or ""
		local points

		for k, v in ipairs(ix.faction.indices) do
			if (k == client:Team()) then
				points = self.spawns[v.uniqueID] or {}

				break
			end
		end

		if (points) then
			for _, v in ipairs(self.backgrounds) do
				if (string.utf8lower(background) == v) then
					background = v

					break
				end
			end

			points = points[background] or points["default"]

			if (points and !table.IsEmpty(points)) then
				local position = table.Random(points)

				client:SetPos(position)
			end
		end
	end
end

function PLUGIN:LoadData()
	self.spawns = self:GetData() or {}
end

function PLUGIN:SaveSpawns()
	self:SetData(self.spawns)

	self:SyncSpawns()
end

function PLUGIN:SyncSpawns(client)
	netstream.Start(client, "ixSyncSpawns", self.spawns)
end

function PLUGIN:PlayerSpawn(client)
	self:SyncSpawns(client)
end


if (CLIENT) then
	ix.option.Add("espShowSpawns", ix.type.bool, false, {
		category = "observer",
		hidden = function()
			return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
		end
	})

	netstream.Hook("ixSyncSpawns", function(spawns)
		PLUGIN.spawns = spawns
	end)

	function PLUGIN:DrawPointESP(points)
		if (ix.option.Get("espShowSpawns", true)) then
			local spawns = self.spawns

			if (spawns) then
				for k, v in pairs(spawns) do
					for k1, v1 in pairs(v) do
						for _, v2 in pairs(v1) do
							points[#points + 1] = {v2,  "spawn:"..k..":"..k1, Color(255, 255, 255)}
						end
					end
				end
			end
		end
	end
end


ix.command.Add("SpawnAdd", {
	description = "@cmdSpawnAdd",
	privilege = "Manage Spawn Points",
	adminOnly = true,
	arguments = {
		ix.type.string,
		bit.bor(ix.type.text, ix.type.optional)
	},
	OnRun = function(self, client, name, background)
		local info = ix.faction.indices[name:utf8lower()]
		local info2
		local faction

		if (!info) then
			for _, v in ipairs(ix.faction.indices) do
				if (ix.util.StringMatches(v.uniqueID, name) or ix.util.StringMatches(L(v.name, client), name)) then
					faction = v.uniqueID
					info = v

					break
				end
			end
		end

		if (info) then
			if background and background != "" then
				if info.noBackground == true then
					client:NotifyLocalized("This faction does not have a selectable background!")
					return false
				end

				local backgroundFound = false

				for _, v in pairs(PLUGIN.backgrounds) do
					if ix.util.StringMatches(v, background) then
						background = v
						info2 = v
						backgroundFound = true
					end
				end

				if (!backgroundFound) then
					client:NotifyLocalized("This is not a valid background for this faction!")
					return false
				end
			else
				background = "default"
			end

			PLUGIN.spawns[faction] = PLUGIN.spawns[faction] or {}
			PLUGIN.spawns[faction][background] = PLUGIN.spawns[faction][background] or {}

			table.insert(PLUGIN.spawns[faction][background], client:GetPos())

			PLUGIN:SaveSpawns()

			name = L(info.name, client)

			if (info2) then
				name = name .. " (" .. L(info2, client) .. ")"
			end

			return "@spawnAdded", name
		else
			return "@invalidFaction"
		end
	end
})

ix.command.Add("SpawnRemove", {
	description = "@cmdSpawnRemove",
	privilege = "Manage Spawn Points",
	adminOnly = true,
	arguments = bit.bor(ix.type.number, ix.type.optional),
	OnRun = function(self, client, radius)
		radius = radius or 120

		local position = client:GetPos()
		local i = 0

		for _, v in pairs(PLUGIN.spawns) do
			for _, v2 in pairs(v) do
				for k3, v3 in pairs(v2) do
					if (v3:Distance(position) <= radius) then
						v2[k3] = nil
						i = i + 1
					end
				end
			end
		end

		if (i > 0) then
			PLUGIN:SaveSpawns()
		end

		return "@spawnDeleted", i
	end
})
