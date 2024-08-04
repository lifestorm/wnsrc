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

PLUGIN.name = "Static Texts"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Allows players to place static texts on the map."

local texts = PLUGIN.texts or {}
PLUGIN.texts = texts

CAMI.RegisterPrivilege({
	Name = "Helix - Increased Text Limit",
	MinAccess = "admin"
})

ix.config.Add("staticTextLifeTime", 240, "Delay before static text will be removed (MINUTES)", nil, {
	data = {min = 1, max = 10080},
	category = "Other"
})

ix.config.Add("staticTextIncreasedLimit", 5, "The increased static text limit.", nil, {
	data = {min = 2, max = 50},
	category = "Other"
})

do
	local COMMAND = {}
	COMMAND.description = "Add static text describing the environment."
	COMMAND.arguments = ix.type.text
	COMMAND.alias = {"StaticTextAdd", "SceneTextAdd"}

	function COMMAND:OnRun(client, text)
		local curTime = CurTime()
		local currentMap = game.GetMap()

		if (client.nextStaticText and client.nextStaticText >= curTime) then
			client:NotifyLocalized("notNow")

			return
		end

		if (text == "") then
			return
		end

		local pos = client:GetPos()
		local count = 0

		for k, v in pairs(texts) do
			if (v.map == currentMap and v.pos:DistToSqr(pos) < 50 * 50) then
				client:Notify("Too close to other text!")

				return
			end

			if (v.steamid == client:SteamID() and v.map == currentMap) then
				count = count + 1
			end
		end

		if (!CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands")) then
			if (CAMI.PlayerHasAccess(client, "Helix - Increased Text Limit")) then
				if (count >= ix.config.Get("staticTextIncreasedLimit")) then
					client:Notify("You have hit the static text limit, please remove at least one before adding a new one.")

					return
				end
			else
				client:Notify("You already have static text placed, remove it before adding a new one.")

				return
			end
		end

		local data = {
			pos = pos + Vector(0, 0, 30),
			text = text,
			name = client:GetName(),
			steamid = client:SteamID(),
			time = os.date("%d/%m/%y %X", os.time()),
			map = currentMap
		}

		PLUGIN:AddStaticText(data)

		client.nextStaticText = curTime + 5
		client:Notify("Static text added.")

		ix.log.Add(client, "staticTextAdded", text)
	end

	ix.command.Add("SceneText", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.description = "Add permanent static text describing the environment."
	COMMAND.arguments = ix.type.text
	COMMAND.alias = {"AdminStaticTextAdd", "AdminSceneTextAdd"}
	COMMAND.adminOnly = true

	function COMMAND:OnRun(client, text)
		local curTime = CurTime()

		if (client.nextStaticText and client.nextStaticText >= curTime) then
			client:NotifyLocalized("notNow")

			return
		end

		if (text == "") then
			return
		end

		local pos = client:GetPos()

		for k, v in pairs(texts) do
			if (v.pos:DistToSqr(pos) < 50 * 50) then
				client:Notify("Too close to other text!")

				return
			end
		end

		local data = {
			pos = pos + Vector(0, 0, 30),
			text = text,
			name = client:GetName(),
			steamid = client:SteamID(),
			time = os.date("%d/%m/%y %X", os.time()),
			permanent = true
		}

		PLUGIN:AddStaticText(data)

		client.nextStaticText = curTime + 5
		client:Notify("Static text added.")

		ix.log.Add(client, "staticTextAdded", text)
	end

	ix.command.Add("AdminSceneText", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.description = "Remove static text."
	COMMAND.alias = {"StaticTextRemove", "RemoveSceneText"}

	function COMMAND:OnRun(client)
		local trace = client:GetEyeTraceNoCursor()

		if (trace.Hit) then
			local pos = trace.HitPos

			for k, v in pairs(texts) do
				if (v.pos:DistToSqr(pos) < 50 * 50) then
					if (v.steamid == client:SteamID() or CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands")) then
						PLUGIN:RemoveStaticText(k)
						client:Notify("Static text removed.")

						ix.log.Add(client, "staticTextRemoved", v)
					else
						client:Notify("You do not have permission to remove this text.")
					end

					return
				end
			end
		end
	end

	ix.command.Add("SceneTextRemove", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.description = "Remove all static text that you own."
	COMMAND.alias = {"StaticTextRemoveAll", "RemoveSceneTextAll"}

	function COMMAND:OnRun(client)
		local steamID = client:SteamID()
		local textCount = 0

		for _, data in pairs(texts) do
			if (data.steamid == steamID) then
				textCount = textCount + 1
			end
		end

		if (textCount > 0) then
			for i = 1, textCount do -- This is kinda dumb but I couldn't be arsed to change how texts are stored; it's not like it's a huge performance hit.
				for id, data in ipairs(texts) do
					if (data.steamid == steamID) then
						PLUGIN:RemoveStaticText(id)
						ix.log.Add(client, "staticTextRemoved", data)

						break
					end
				end
			end

			client:Notify("You have removed " .. textCount .. " static texts.")
		else
			client:Notify("You do not own any static texts!")
		end
	end

	ix.command.Add("SceneTextRemoveAll", COMMAND)
end

if (CLIENT) then
	function PLUGIN:HUDPaint()
		if (texts and !table.IsEmpty(texts)) then
			local client = LocalPlayer()
			local clientPos = client:EyePos()
			local scrW = ScrW()
			local cx, cy = scrW * 0.5, ScrH() * 0.5
			local hasPermission = CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands")

			for k, txt in pairs(texts) do
				if (clientPos:DistToSqr(txt.pos) > 90000) then
					continue
				end

				local trace = util.TraceLine({
					start = clientPos,
					endpos = txt.pos,
					mask = MASK_OPAQUE
				})

				if (trace.Hit) then
					continue
				end

				local pos = txt.pos:ToScreen()
				local camMult = (1 - math.Distance(cx, cy, pos.x, pos.y) / scrW * 1.5)
				local distanceMult = (1 - clientPos:Distance(txt.pos) * 0.003) -- 0.003 == 1/300
				local alpha = 255 * camMult * distanceMult
				local col1, col2 = Color(255, 255, 255, alpha), Color(0, 0, 0, alpha)
				local font = "ixGenericFont"

				surface.SetFont(font)

				local _, fullH = surface.GetTextSize(txt.text)
				local lines = ix.util.WrapText(txt.text, scrW * 0.25, font)

				if (input.IsKeyDown(KEY_LALT) and hasPermission) then
					table.insert(lines, txt.name.." ("..txt.steamid..")")
					table.insert(lines, txt.time)
				end

				local offset = 4
				local curY = pos.y - ((fullH + offset) * #lines) / 2

				for k1, v1 in pairs(lines) do
					local w, h = surface.GetTextSize(v1)

					draw.SimpleTextOutlined(v1, font, pos.x - w / 2, curY, col1, nil, nil, 1, col2)

					curY = curY + h + offset
				end
			end
		end
	end

	netstream.Hook("ixStaticTextAdd", function(data)
		table.insert(texts, data)
	end)

	netstream.Hook("ixStaticTextRemove", function(id)
		table.remove(texts, id)
	end)

	netstream.Hook("ixStaticTextSet", function(data)
		texts = data
	end)
else
	ix.log.AddType("staticTextAdded", function(client, text)
		return string.format("%s has added static text: %s", client:GetName(), text)
	end)

	ix.log.AddType("staticTextRemoved", function(client, text)
		return string.format("%s has removed static text: %s", client:GetName(), text)
	end)

	function PLUGIN:AddStaticText(data)
		netstream.Start(nil, "ixStaticTextAdd", data)

		local id = table.insert(texts, data)

		if (data.permanent) then return end

		timer.Create("ixStaticText"..id, data.timeLeft or ix.config.Get("staticTextLifeTime", 240) * 60, 1, function()
			self:RemoveStaticText(id)
		end)
	end

	function PLUGIN:RemoveStaticText(id)
		table.remove(texts, id)

		local timerId = "ixStaticText"..id

		if (timer.Exists(timerId)) then
			timer.Remove(timerId)
		end

		netstream.Start(nil, "ixStaticTextRemove", id)
	end

	function PLUGIN:PlayerInitialSpawn(client)
		timer.Simple(2, function()
			netstream.Start(client, "ixStaticTextSet", texts)
		end)
	end

	function PLUGIN:SaveData()
		for k, v in pairs(texts) do
			local timerId = "ixStaticText"..k

			if (timer.Exists(timerId)) then
				v.timeLeft = timer.TimeLeft(timerId)
			end
		end

		ix.data.Set("statictexts", texts)
	end

	function PLUGIN:LoadData()
		local loaded = ix.data.Get("statictexts", {})

		for k, v in pairs(loaded) do
			self:AddStaticText(v)
		end
	end
end