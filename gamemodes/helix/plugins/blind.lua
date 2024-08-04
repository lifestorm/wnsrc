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

PLUGIN.name = "Blind Commands"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Adds commands to blind the players by making their screen completely black."

--luacheck: globals BLIND_NONE BLIND_TARGET BLIND_ALL
BLIND_NONE = 0
BLIND_TARGET = 1
BLIND_ALL = 2

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Blind",
	MinAccess = "admin"
})

ix.command.Add("PlyBlind", {
	description = "Blinds the specified player.",
	privilege = "Manage Blind",
	arguments = {
		ix.type.player
	},
	OnRun = function(self, client, target)
		if (IsValid(target)) then
			target:SetBlind(BLIND_TARGET)
		else
			client:NotifyLocalized("plyNotValid")
		end
	end
})

ix.command.Add("PlyUnBlind", {
	description = "Unblinds the specified player.",
	privilege = "Manage Blind",
	arguments = {
		ix.type.player
	},
	OnRun = function(self, client, target)
		if (IsValid(target)) then
			target:SetBlind(BLIND_NONE)
		else
			client:NotifyLocalized("plyNotValid")
		end
	end
})

PLUGIN.blindAll = false

ix.command.Add("PlyBlindAll", {
	description = "Blinds all players on the server.",
	privilege = "Manage Blind",
	OnRun = function(self, client)
		for _, v in ipairs(player.GetAll()) do
			v:SetBlind(BLIND_ALL)
		end

		PLUGIN.blindAll = true
	end
})

ix.command.Add("PlyUnBlindAll", {
	description = "Unblinds all players on the server.",
	privilege = "Manage Blind",
	OnRun = function(self, client)
		for _, v in ipairs(player.GetAll()) do
			v:SetBlind(BLIND_NONE)
		end

		PLUGIN.blindAll = false
	end
})

ix.char.RegisterVar("blind", {
	field = "blind",
	fieldType = ix.type.number,
	default = BLIND_NONE,
	isLocal = true,
	bNoDisplay = true
})

if (CLIENT) then
	local wasBlind = false
	local scrW, scrH = ScrW(), ScrH()

	function PLUGIN:HUDPaintBackground()
		if (self.blind) then
			local curTime = CurTime()
			local textTime = 5

			local client = LocalPlayer()
			local reduceBlindness = client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()
			draw.RoundedBox(0, 0, 0, scrW, scrH, Color(0, 0, 0, reduceBlindness and 200 or 255))

			if (!wasBlind) then
				wasBlind = curTime + textTime
			elseif (isnumber(wasBlind) and curTime < wasBlind) then
				local timeLeft = wasBlind - curTime
				local text = "You have been blinded by the administration."
				local font = "WNBleedingText"

				surface.SetFont(font)
				local w, h = surface.GetTextSize(text)
				local x, y = scrW * 0.5, scrH * 0.75

				draw.SimpleTextOutlined(text, font, x - w * 0.5, y - h * 0.5, Color(255, 255, 255, 510 * timeLeft * 0.4), nil, nil, 1, Color(0, 0, 0, 510 * timeLeft * 0.4))
			else
				wasBlind = true
			end
		end
	end

	function PLUGIN:CharacterLoaded(character)
		local blind = character:GetBlind()

		if (blind == BLIND_TARGET or PLUGIN.blindAll) then
			PLUGIN.blind = true
		elseif (blind == BLIND_ALL and !PLUGIN.blindAll) then
			PLUGIN.blind = false
		end
	end

	function PLUGIN:ShouldDrawCrosshair()
		if (self.blind) then
			return false
		end
	end

	netstream.Hook("ixBlindPlayer", function(blind)
		local delay = 1

		blind = blind != BLIND_NONE

		LocalPlayer():ScreenFade(blind and SCREENFADE.OUT or SCREENFADE.IN, Color(0, 0, 0, 255), delay, 0)

		if (blind) then
			wasBlind = false

			timer.Simple(delay, function()
				PLUGIN.blind = blind
			end)
		else
			PLUGIN.blind = blind
		end
	end)
else
	local playerMeta = FindMetaTable("Player")

	function playerMeta:SetBlind(blind)
		if (self:GetCharacter()) then
			self:GetCharacter():SetBlind(blind)
		end

		netstream.Start(self, "ixBlindPlayer", blind)
	end

	function playerMeta:GetBlind()
		if (self:GetCharacter()) then
			return self:GetCharacter():GetBlind()
		end

		return BLIND_NONE
	end
end
