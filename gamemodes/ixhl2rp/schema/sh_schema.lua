--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


Schema.name = "HL2 RP"
Schema.author = "willard.network"
Schema.description = "Experience a next-level Half-Life 2 Roleplay experience. Taking inspiration from games such as Divinity Original Sin and Xcom 2. Featuring a completely overhauled combat system, gameplay and UI."

ix.util.Include("sh_configs.lua")
ix.util.Include("sh_commands.lua")

ix.util.Include("cl_schema.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_groups.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sh_voices.lua")
ix.util.Include("sh_voices_ota.lua")
ix.util.Include("sv_schema.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("libs/thirdparty/cl_imgui.lua")
ix.util.Include("libs/thirdparty/cl_3d2dvgui.lua")

-- CP models
for i = 1, 9 do
	ix.anim.SetModelClass("models/wn7new/metropolice/male_0"..i..".mdl", "metrocop")
end
for i = 1, 7 do
	ix.anim.SetModelClass("models/wn7new/metropolice/female_0"..i..".mdl", "metrocop_female")
end

for i = 1, 9 do
	ix.anim.SetModelClass("models/wn7new/metropolice_c8/male_0"..i..".mdl", "metrocop")
end
for i = 1, 7 do
	ix.anim.SetModelClass("models/wn7new/metropolice_c8/female_0"..i..".mdl", "metrocop_female")
end

for i = 1, 9 do
	ix.anim.SetModelClass("models/wn7new/metropolice_rebel/male_0"..i..".mdl", "metrocop")
end

for i = 1, 7 do
	ix.anim.SetModelClass("models/wn7new/metropolice_rebel/female_0"..i..".mdl", "metrocop_female")
end

-- Combine 2.0 pack
ix.anim.SetModelClass("models/willardnetworks/combine/antibody.mdl", "citizen_male")
ix.anim.SetModelClass("models/wn/ordinal.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/ota_commander.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/ota_elite.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/ota_elite_summit.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/ota_shotgunner.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/ota_skylegion.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/ota_soldier.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/soldier.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/suppressor.mdl", "overwatch")
ix.anim.SetModelClass("models/wn/wallhammer.mdl", "overwatch")

if (SERVER) then
	resource.AddWorkshop("2066864990") -- WN Content Pack
	resource.AddWorkshop("2920298301") -- Willard Networks V2 Models
	resource.AddWorkshop("131759821") -- VJ Base
	resource.AddWorkshop("2126368202") -- [VJ] Short Stories NPCs
	resource.AddWorkshop("1336622735") -- Modular Canal Props
	resource.AddWorkshop("2875205147") -- Willard Sound Pack
	resource.AddWorkshop("2228994615") -- [Half Life: Alyx] Xen Pack (Props)
	resource.AddWorkshop("2473879362") -- Willard 2.0 Combine Pack
	resource.AddWorkshop("2875203234") -- [Optional] WN HL:A Voicelines
	resource.AddWorkshop("2233731395") -- Scene Builder
	resource.AddWorkshop("2447979470") -- StormFox 2 Content
	resource.AddWorkshop("2043900984") -- [Half Life: Alyx] Infestation Control props
	resource.AddWorkshop("2225220690") -- [Half Life: Alyx] Xen Foam Pack (Props)
	resource.AddWorkshop("2350858257") -- eProtect - Content
	resource.AddWorkshop("2206993805") -- slib - Stromic's Library
	resource.AddWorkshop("2169730364") -- Half Life: Alyx - Combine VO
	resource.AddWorkshop("2840031720") -- [TFA] Base
	resource.AddWorkshop("2131057232") -- [ArcCW] Arctic's Customizable Weapons (Base Only)
	resource.AddWorkshop("3044111523") -- [ArcCW] Willard Shared Attachments
	resource.AddWorkshop("3143931771") -- [ArcCW] Willard Resistance Weapons
	resource.AddWorkshop("3143867497") -- [ArcCW] Willard Overwatch Weapons
	resource.AddWorkshop("3043853773") -- [ArcCW] Willard Junk Weapons
	resource.AddWorkshop("2548809283") -- Half-Life Resurgence
	resource.AddWorkshop("1551310214") -- Placeable Particle Effects

	-- T6
	resource.AddWorkshop("151119348") -- Conscripts
	resource.AddWorkshop("164165599") -- Female Conscripts
	resource.AddWorkshop("172374701") -- Hazmat Conscripts
	resource.AddWorkshop("2639959090") -- Manable Emplacements
end

Schema.colors = {
	["aliceblue"] = Color(240, 248, 255),
	["antiquewhite"] = Color(250, 235, 215),
	["aqua"] = Color(0, 255, 255),
	["aquamarine"] = Color(127, 255, 212),
	["azure"] = Color(240, 255, 255),
	["beige"] = Color(245, 245, 220),
	["bisque"] = Color(255, 228, 196),
	["black"] = Color(0, 0, 0),
	["blanchedalmond"] = Color(255, 235, 205),
	["blue"] = Color(0, 100, 255),
	["blueviolet"] = Color(138, 43, 226),
	["brown"] = Color(165, 42, 42),
	["burlywood"] = Color(222, 184, 135),
	["cadetblue"] = Color(95, 158, 160),
	["chartreuse"] = Color(127, 255, 0),
	["chocolate"] = Color(210, 105, 30),
	["coral"] = Color(255, 127, 80),
	["cornflowerblue"] = Color(100, 149, 237),
	["cornsilk"] = Color(255, 248, 220),
	["crimson"] = Color(220, 20, 60),
	["cyan"] = Color(0, 255, 255),
	["darkblue"] = Color(0, 0, 139),
	["darkcyan"] = Color(0, 139, 139),
	["darkgoldenrod"] = Color(184, 134, 11),
	["darkgray"] = Color(169, 169, 169),
	["darkgreen"] = Color(0, 100, 0),
	["darkgrey"] = Color(169, 169, 169),
	["darkkhaki"] = Color(189, 183, 107),
	["darkmagenta"] = Color(139, 0, 139),
	["darkolivegreen"] = Color(85, 107, 47),
	["darkorange"] = Color(255, 140, 0),
	["darkorchid"] = Color(153, 50, 204),
	["darkred"] = Color(139, 0, 0),
	["darksalmon"] = Color(233, 150, 122),
	["darkseagreen"] = Color(143, 188, 143),
	["darkslateblue"] = Color(72, 61, 139),
	["darkslategray"] = Color(47, 79, 79),
	["darkslategrey"] = Color(47, 79, 79),
	["darkturquoise"] = Color(0, 206, 209),
	["darkviolet"] = Color(148, 0, 211),
	["deeppink"] = Color(255, 20, 147),
	["deepskyblue"] = Color(0, 191, 255),
	["dimgray"] = Color(105, 105, 105),
	["dimgrey"] = Color(105, 105, 105),
	["dodgerblue"] = Color(30, 144, 255),
	["firebrick"] = Color(178, 34, 34),
	["floralwhite"] = Color(255, 250, 240),
	["forestgreen"] = Color(34, 139, 34),
	["fuchsia"] = Color(255, 0, 255),
	["gainsboro"] = Color(220, 220, 220),
	["ghostwhite"] = Color(248, 248, 255),
	["gold"] = Color(255, 215, 0),
	["goldenrod"] = Color(218, 165, 32),
	["gray"] = Color(81, 81, 81),
	["green"] = Color(38, 106, 46),
	["greenyellow"] = Color(173, 255, 47),
	["grey"] = Color(81, 81, 81),
	["honeydew"] = Color(240, 255, 240),
	["hotpink"] = Color(255, 105, 180),
	["indianred"] = Color(205, 92, 92),
	["indigo"] = Color(75, 0, 130),
	["ivory"] = Color(255, 255, 240),
	["khaki"] = Color(240, 230, 140),
	["lavender"] = Color(230, 230, 250),
	["lavenderblush"] = Color(255, 240, 245),
	["lawngreen"] = Color(124, 252, 0),
	["lemonchiffon"] = Color(255, 250, 205),
	["lightblue"] = Color(173, 216, 230),
	["lightcoral"] = Color(240, 128, 128),
	["lightcyan"] = Color(224, 255, 255),
	["lightgoldenrodyellow"] = Color(250, 250, 210),
	["lightgray"] = Color(211, 211, 211),
	["lightgreen"] = Color(144, 238, 144),
	["lightgrey"] = Color(211, 211, 211),
	["lightpink"] = Color(255, 182, 193),
	["lightsalmon"] = Color(255, 160, 122),
	["lightseagreen"] = Color(32, 178, 170),
	["lightskyblue"] = Color(135, 206, 250),
	["lightslategray"] = Color(119, 136, 153),
	["lightslategrey"] = Color(119, 136, 153),
	["lightsteelblue"] = Color(176, 196, 222),
	["lightyellow"] = Color(255, 255, 224),
	["lime"] = Color(0, 255, 0),
	["limegreen"] = Color(50, 205, 50),
	["linen"] = Color(250, 240, 230),
	["magenta"] = Color(255, 0, 255),
	["maroon"] = Color(103, 0, 42),
	["mediumaquamarine"] = Color(102, 205, 170),
	["mediumblue"] = Color(0, 0, 205),
	["mediumorchid"] = Color(186, 85, 211),
	["mediumpurple"] = Color(147, 112, 219),
	["mediumseagreen"] = Color(60, 179, 113),
	["mediumslateblue"] = Color(123, 104, 238),
	["mediumspringgreen"] = Color(0, 250, 154),
	["mediumturquoise"] = Color(72, 209, 204),
	["mediumvioletred"] = Color(199, 21, 133),
	["midnightblue"] = Color(25, 25, 112),
	["mintcream"] = Color(245, 255, 250),
	["mistyrose"] = Color(255, 228, 225),
	["moccasin"] = Color(255, 228, 181),
	["navajowhite"] = Color(255, 222, 173),
	["navy"] = Color(0, 0, 128),
	["oldlace"] = Color(253, 245, 230),
	["olive"] = Color(128, 128, 0),
	["olivedrab"] = Color(107, 142, 35),
	["orange"] = Color(255, 122, 0),
	["orangered"] = Color(255, 69, 0),
	["orchid"] = Color(218, 112, 214),
	["palegoldenrod"] = Color(238, 232, 170),
	["palegreen"] = Color(152, 251, 152),
	["paleturquoise"] = Color(175, 238, 238),
	["palevioletred"] = Color(219, 112, 147),
	["papayawhip"] = Color(255, 239, 213),
	["peachpuff"] = Color(255, 218, 185),
	["peru"] = Color(205, 133, 63),
	["pink"] = Color(255, 192, 203),
	["plum"] = Color(221, 160, 221),
	["powderblue"] = Color(176, 224, 230),
	["purple"] = Color(102, 51, 153),
	["rebeccapurple"] = Color(102, 51, 153),
	["red"] = Color(255, 0, 0),
	["rosybrown"] = Color(188, 143, 143),
	["royalblue"] = Color(65, 105, 225),
	["saddlebrown"] = Color(139, 69, 19),
	["salmon"] = Color(250, 128, 114),
	["sandybrown"] = Color(244, 164, 96),
	["seagreen"] = Color(46, 139, 87),
	["seashell"] = Color(255, 245, 238),
	["sienna"] = Color(160, 82, 45),
	["silver"] = Color(192, 192, 192),
	["skyblue"] = Color(135, 206, 235),
	["slateblue"] = Color(106, 90, 205),
	["slategray"] = Color(112, 128, 144),
	["slategrey"] = Color(112, 128, 144),
	["snow"] = Color(255, 250, 250),
	["springgreen"] = Color(0, 255, 127),
	["steelblue"] = Color(70, 130, 180),
	["tan"] = Color(210, 180, 140),
	["teal"] = Color(0, 128, 128),
	["thistle"] = Color(216, 191, 216),
	["tomato"] = Color(255, 99, 71),
	["turquoise"] = Color(64, 224, 208),
	["violet"] = Color(238, 130, 238),
	["wheat"] = Color(245, 222, 179),
	["white"] = Color(255, 255, 255),
	["whitesmoke"] = Color(245, 245, 245),
	["yellow"] = Color(255, 255, 0),
	["yellowgreen"] = Color(154, 205, 50),
}


if (CLIENT) then
	CHAT_RECOGNIZED = CHAT_RECOGNIZED or {}
	CHAT_RECOGNIZED["wd"] = true
end

function Schema:ZeroNumber(number, length)
	number = tostring(number)
	local amount = math.max(0, length - string.len(number))
	return string.rep("0", amount)..number
end

function Schema:IsCombineRank(text, rank)
	return string.find(text, "[%D+]"..rank.."[%D+]")
end

do
	local CLASS = {}
	CLASS.color = Color(254, 39, 39)
	CLASS.format = "Dispatch broadcasts \"%s\""

	function CLASS:CanSay(speaker, text)
		if (speaker:IsWorld()) then return true end

		if (!speaker:IsDispatch() and speaker:Team() != FACTION_SERVERADMIN) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end

	local dispatchIcon = ix.util.GetMaterial("willardnetworks/chat/dispatch_icon.png")

	function CLASS:OnChatAdd(speaker, text)
		local oldFont = self.font 
		local font = hook.Run("GetSpeakerFont", speaker)

		self.font = font

		if ix.option.Get("standardIconsEnabled") then
			chat.AddText(dispatchIcon, self.color, string.format(self.format, text))
		else
			chat.AddText(self.color, string.format(self.format, text))
		end
		self.font = oldFont
	end

	ix.chat.Register("dispatch", CLASS)
	ix.chat.Register("worlddispatch", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(175, 125, 100)
	CLASS.format = "%s requests \"%s\""

	function CLASS:CanHear(speaker, listener)
		if (ix.chat.classes.request:CanHear(speaker, listener)) then
			return false
		end

		local chatRange = ix.config.Get("chatRange", 280)

		return (speaker:Team() == FACTION_CITIZEN and listener:Team() == FACTION_CITIZEN)
		and (speaker:GetPos() - listener:GetPos()):LengthSqr() <= (chatRange * chatRange)
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("request_eavesdrop", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(151, 161, 255)
	CLASS.format = "%s broadcasts \"%s\""

	function CLASS:CanSay(speaker, text)
		if (speaker and speaker:Team() != FACTION_ADMIN and !speaker:GetCharacter():GetInventory():HasItem("broadcasting_device") and !speaker:GetNetVar("broadcastAuth", false)) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end

	local broadcastIcon = ix.util.GetMaterial("willardnetworks/chat/broadcast_icon.png")

	function CLASS:OnChatAdd(speaker, text, anonymous, data)
		if (ix.option.Get("standardIconsEnabled")) then
			chat.AddText(broadcastIcon, self.color, string.format(self.format, (speaker and speaker.Name and speaker:Name() or data and data.speakerName and data.speakerName or ""), text))
		else
			chat.AddText(self.color, string.format(self.format, (speaker and speaker.Name and speaker:Name() or data and data.speakerName and data.speakerName or ""), text))
		end
	end

	ix.chat.Register("broadcast", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(151, 161, 255)
	CLASS.format = "*** %s %s"

	function CLASS:CanSay(speaker, text)
		if (speaker:Team() != FACTION_ADMIN and !speaker:GetCharacter():GetInventory():HasItem("broadcasting_device")) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end

	local broadcastIcon = ix.util.GetMaterial("willardnetworks/chat/broadcast_icon.png")
	function CLASS:OnChatAdd(speaker, text)
		if ix.option.Get("standardIconsEnabled") then
			chat.AddText(broadcastIcon, self.color, string.format(self.format, (speaker and speaker.Name and speaker:Name() or ""), text))
		else
			chat.AddText(self.color, string.format(self.format, (speaker and speaker.Name and speaker:Name() or ""), text))
		end
	end

	ix.chat.Register("broadcastMe", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(151, 161, 255)
	CLASS.format = "***' %s"

	function CLASS:CanSay(speaker, text)
		if (speaker:Team() != FACTION_ADMIN and !speaker:GetCharacter():GetInventory():HasItem("broadcasting_device")) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end

	local broadcastIcon = ix.util.GetMaterial("willardnetworks/chat/broadcast_icon.png")
	function CLASS:OnChatAdd(speaker, text)
		if ix.option.Get("standardIconsEnabled") then
			chat.AddText(broadcastIcon, self.color, string.format(self.format, text))
		else
			chat.AddText(self.color, string.format(self.format, text))
		end
	end

	ix.chat.Register("broadcastIt", CLASS)
end

ix.chat.Register("wd", {
	format = "%s whispers to %s \"%s\"",
	icon = "willardnetworks/chat/whisper_icon.png",
	color = Color(158, 162, 191, 255),
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		local name = bAnonymous and L"someone" or hook.Run("GetCharacterName", speaker, chatType) or (IsValid(speaker) and speaker:Name() or "Console")
		local targetName = bAnonymous and L"someone" or hook.Run("GetCharacterName", data.target, chatType) or (IsValid(data.target) and data.target:Name() or "Console")
		local oldFont = self.font 
		local font = hook.Run("GetSpeakerFont", speaker)

		self.font = font
		if (ix.option.Get("standardIconsEnabled")) then
			chat.AddText(ix.util.GetMaterial(self.icon), self.color, string.format(self.format, name, targetName, text))
		else
			chat.AddText(self.color, string.format(self.format, name, targetName, text))
		end
		self.font = oldFont
	end,
	prefix = {"/W", "/Whisper"},
	description = "@cmdW",
	indicator = "chatWhispering"
})

function Schema:IsVowel(letter)
	letter = string.utf8lower(letter);
	return (letter == "a" or letter == "e" or letter == "i"
	or letter == "o" or letter == "u");
end

function Schema:FirstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function Schema:Pluralize(text)
	if (string.utf8sub(text, -2) != "fe") then
		local lastLetter = string.utf8sub(text, -1)

		if (lastLetter == "y") then
			if (self:IsVowel(string.utf8sub(text, string.utf8len(text) - 1, 2))) then
				return string.utf8sub(text, 1, -2).."ies"
			else
				return text.."s"
			end
		elseif (lastLetter == "h") then
			return text.."es"
		elseif (lastLetter != "s") then
			return text.."s"
		else
			return text
		end
	else
		return string.utf8sub(text, 1, -3).."ves"
	end
end

-- A function to shuffle text but still maintain a sort of "readability" xD
function Schema:ShuffleText(shuffleText)
	if !isstring(shuffleText) then
		return false
	end

	local shuffleTable = {}
	local n = 0

	shuffleText:gsub("%a", function(c)
		if shuffleTable[c] == nil then
			n = n + 1
			shuffleTable[n] = c
			shuffleTable[c] = n
		end
	end)

	for i = n, 2, -1 do
		local j = math.random(i)
		shuffleTable[i], shuffleTable[j] = shuffleTable[j] -- , shuffleTable[i] (adding this will cause it to shuffle completely)
	end

	local shuffledText = shuffleText:gsub("%a", function (c) return shuffleTable[shuffleTable[c]] end)

	return shuffledText
end

ix.flag.Add("U", "Access to certain Combine commands.")
ix.flag.Add("M", "Access to modify Combine Locks and Cards")
ix.flag.Add("F", "Access to use or modify Reversed-Engineered Combine Tech")
ix.flag.Add("J", "Access to computer.")
ix.flag.Add("B", "Access to Black Market")
ix.flag.Add("D", "Removes all drug effects")
ix.flag.Add("1", "For BMD Characters - Alpha")
ix.flag.Add("2", "For BMD Characters - Beta")
ix.flag.Add("3", "For BMD Characters - Gamma")
ix.flag.Add("4", "For BMD Characters - Delta")
ix.flag.Add("5", "For BMD Characters - Epsilon")
ix.flag.Add("6", "For BMD Characters - Zeta")
