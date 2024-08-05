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

PLUGIN.name = "Dispatch Unit Radio"
PLUGIN.description = "Plays custom Dispatch voicelines on a units radio"
PLUGIN.author = "Jei-Dev"
PLUGIN.version = 0.1

if (SERVER) then
	ix.log.AddType("unitRadio", function(client, message)
		return string.format("Dispatch announces out of %s's radio: %s", client:Name(), message)
	end)
end

ix.lang.AddTable("english", {
	cmdDispUnitRadio = "Rolls a number between 0 and 20, with the ability to add bonuses from attributes.",
	cmdTargError = "This command needs a valid Unit. OTA or CP.",
	invalidSkill = "That is not a valid skill!",
	chatRolling = "Rolling...",
})

do
    local CLASS = {}

    CLASS.indicator = "chatTalking"
    CLASS.format = "Dispatch announces out of %s's radio: %s"
    CLASS.color = Color(0, 123, 255)
    
    function CLASS:CanHear(speaker, listener)
    	local chatRange = ix.config.Get("chatRange", 280)

    	return (speaker:GetPos() - listener:GetPos()):LengthSqr() <= (chatRange * chatRange)
    end

    function CLASS:OnChatAdd(speaker, message, anonymous, data)
    	local characterName = hook.Run("GetCharacterName", data, "say") or data:Name()

    	chat.AddText(self.color, string.format(self.format, characterName, message))
    end

    ix.chat.Register("unitRadio", CLASS)
end

do
	local COMMAND = {}
	COMMAND.arguments = {
        ix.type.character,
        ix.type.text
    }
    COMMAND.argumentNames = {
        "Unit", 
        "Message"
    }
    COMMAND.description = "@cmdDispUnitRadio"

	function COMMAND:OnRun(client, target, message)
        if (!client and !IsValid(client)) then return end
        if (!target) then client:NotifyLocalized("cmdTargError") return end

        print(client:GetName().." isValid Client")
        local character = client:GetCharacter()
        local getFaction = target:GetFaction()
        local getClass = target:GetClass()

        print(character:GetName().." isValid Character")
        if (character:GetFaction() != FACTION_OVERWATCH) then return end

        if (character:GetFaction() != FACTION_OVERWATCH) then print(client:GetName().." is "..client:GetFaction().." not Overwatch AI") end
        print(target:GetName().." : Target")

        if (getClass == CLASS_OW_SCANNER or getClass == CLASS_CP_RL or getClass == CLASS_CP_CPT or getClass == CLASS_CP_CMD or getClass == CLASS_OVERSEER or getFaction == FACTION_OTA or getFaction == FACTION_CP) then
        print(target:GetName().." is "..getClass.." and "..getFaction.." : Valid")
        end

        ix.chat.Send(target:GetPlayer(), "unitRadio", message, false)
        print(client:GetName().." sent message: '"..message.."' to "..target:GetName())
    end

    ix.command.Add("UnitRadio", COMMAND)
end