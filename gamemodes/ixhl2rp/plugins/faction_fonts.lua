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

PLUGIN.name = "Faction Fonts"
PLUGIN.description = "Adds different fonts to different factions"
PLUGIN.author = "gb"


ix.config.Add("allowFactionFonts", true, "Whether or not different fonts for different factions are enabled. (Only OTAs and Dispatch)", nil, {
	category = "Chat"
})

function PLUGIN:GetSpeakerFont(client)
	local character = client:GetCharacter()
	local faction = character:GetFaction()

	if ix.config.Get("allowFactionFonts", true) then 
		if faction == FACTION_OVERWATCH or faction == FACTION_OTA then 
			return "ixDispatchFont"
		else 
			return "ixChatFont" 
		end 
	else 
		return "ixChatFont" 
	end 
end

function PLUGIN:GetSpeakerYellFont(client)
	if ix.config.Get("allowFactionFonts", true) then 
		local character = client:GetCharacter()
		local faction = character:GetFaction()

		if faction == FACTION_OVERWATCH or faction == FACTION_OTA  then 
            return "ixDispatchYellFont"
		else 
			return "ixChatYellFont" 
		end 
	else 
		return "ixChatYellFont" 
	end  
end

if (CLIENT) then
	function PLUGIN:LoadFonts(font, genericFont)
		
		surface.CreateFont("ixDispatchFont", {
			font = "Courier New", 
			size = math.max(ScreenScale(7), 16) * ix.option.Get("chatFontScale", 1),
			extended = true,
			weight = 750,
			antialias = false
		})

		surface.CreateFont("ixDispatchFontItalic", {
			font = "Courier New", 
			size = math.max(ScreenScale(7), 16) * ix.option.Get("chatFontScale", 1),
			extended = true,
			weight = 750,
			antialias = true,
			italic = true
		})

		surface.CreateFont("ixDispatchYellFont", {
			font = "Courier New", 
			size = math.max(ScreenScale(8), 17) * ix.option.Get("chatFontScale", 1),
			extended = true,
			weight = 800,
			antialias = false
		})

		surface.CreateFont("ixDispatchYellFontItalic", {
			font = "Courier New", 
			size = math.max(ScreenScale(8), 17) * ix.option.Get("chatFontScale", 1),
			extended = true,
			weight = 800,
			antialias = true,
			italic = true 
		})
	end
end
