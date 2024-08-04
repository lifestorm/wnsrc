--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--[[
    ring ring ring ring - LUA PHONE
       ,==.-------.
      (    ) ====  \
      ||  | [][][] |
    ,8||  | [][][] |
    8 ||  | [][][] |
    8 (    ) O O O /
    '88`=='-------'
]]

local PLUGIN = PLUGIN

PLUGIN.name = "Phones"
PLUGIN.description = "Adds landlines, pagers, and ways to route them"
PLUGIN.author = "M!NT"

ix.phone = ix.phone or {}
ix.phone.switch = ix.phone.switch or {}

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

CAMI.RegisterPrivilege({
	Name = "Helix - Use Phones",
	MinAccess = "user"
})

ix.command.Add("HangupPhone", {
    alias = "HP",
    description = "Odłóż telefon, na który patrzysz.",
    arguments = {},
    privilege = "Use Phones",
    OnRun = function(self, client)
        PLUGIN:runHangupOnClient(client)
    end
})

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Phones",
	MinAccess = "admin"
})

ix.command.Add("EditLandline", {
    description = "Edytuj telefon stacjonarny, na który obecnie patrzysz.",
    arguments = {
        ix.type.number,
        ix.type.number,
        ix.type.text
    },
    privilege = "Manage Phones",
    OnRun = function(self, client, pbx, extension, publicName)
        if (!pbx or !extension or !publicName or string.len(publicName) < 1) then
            client:NotifyLocalized("Podałeś nieprawidłowy argument")
        end

        -- perform input validations
        if (pbx < 1 or pbx > 9) then
            client:NotifyLocalized("Podany PBX jest nieprawidłowy! (musi być liczbą pomiędzy 1 a 10)")
            return
        end

        if (!ix.phone.switch:ExchangeExists(pbx)) then
            client:NotifyLocalized("Podany PBX '"..tostring(pbx).."' nie istnieje.")
            return
        end

        if (extension < 100 or extension > 999) then
            client:NotifyLocalized("Podane rozszerzenie jest nieprawidłowe! (musi być liczbą pomiędzy 100 a 1000")
            return
        end

        if (string.len(publicName) < 1) then
            client:NotifyLocalized("Podana nazwa publiczna jest nieprawidłowa! (musi mieć długość większą niż 1)")
            return
        end

        local data = {}
            data.start = client:GetShootPos()
            data.endpos = data.start + client:GetAimVector() * 96
            data.filter = client
        local target = util.TraceLine(data).Entity

        if (!IsValid(target) or target.PrintName != "Landline Phone") then
            client:NotifyLocalized("Nie patrzysz obecnie na telefon.")
            return
        end

        if (ix.phone.switch:DestExists(target.currentPBX, target.currentExtension)) then
            print("exists")
            ix.phone.switch:RmDest(target.currentPBX, target.currentExtension)
        end

        if (!ix.phone.switch:AddDest(pbx, extension, publicName, target.endpointID)) then
            client:NotifyLocalized("Nie można zarejestrować telefonu przy użyciu podanych argumentów")
            return
        end

        target.currentName      = publicName
        target.currentPBX       = pbx
        target.currentExtension = extension

        client:NotifyLocalized("Pomyślnie zaktualizowano telefon stacjonarny.")
    end
})

ix.command.Add("AddPBX", {
    description = "Dodaj nową centralę PBX, jeśli jeszcze nie istnieje.",
    arguments = {ix.type.number},
    privilege = "Manage Phones",
    OnRun = function(self, client, pbx)
        if (!pbx or pbx < 1 or pbx > 9) then
            client:NotifyLocalized("Podany PBX jest nieprawidłowy! (musi być liczbą pomiędzy 1 a 10)")
            return
        end

        if (ix.phone.switch:AddExchange(pbx)) then
            client:NotifyLocalized("PBX '"..tostring(pbx).."' został pomyślnie utworzony!")
        else
            client:NotifyLocalized("PBX '"..tostring(pbx).."' już istnieje!")
            return
        end
    end
})

ix.command.Add("RemovePBX", {
    description = "Usuń istniejącą centralę PBX (zatrzyma wszystkie aktywne połączenia na tej centrali PBX i wyrejestruje wszystkie aktualnie podłączone telefony!)",
    arguments = {ix.type.number},
    privilege = "Manage Phones",
    OnRun = function(self, client, pbx)
        if (!pbx or pbx < 1 or pbx > 9) then
            client:NotifyLocalized("Podany PBX jest nieprawidłowy! (musi być liczbą pomiędzy 1 a 10)")
            return
        end

        if (!ix.phone.switch:ExchangeExists(pbx)) then
            client:NotifyLocalized("PBX '"..tostring(pbx).."' nie istnieje!")
            return
        end

        -- stop all active connections
        for ext, md in ipairs(ix.phone.switch.exchanges[pbx]) do
            local connMd = ix.phone.switch:GetActiveConnection(pbx, ext)
            if (istable(connMd)) then
                ix.phone.switch:Disconnect(connMD.targetConnID)
            end
        end

        ix.phone.switch:RmExchange(pbx)

        client:NotifyLocalized("PBX '"..tostring(pbx).."' został zdekonstruowany.")
    end
})

ix.char.RegisterVar("landlineConnection", {
	field = "landlineConnection",
	fieldType = ix.type.table,
	default = {
        active = false,
        exchange = nil,
        extension = nil
    },
	bNoDisplay = true,
	isLocal = true,
	OnSet = function(self, value)
		local client = self:GetPlayer()

        if (!IsValid(client)) then
            return nil
        end

        self.vars.landlineConnection = {
            active    = value["active"],
            exchange  = value["exchange"],
            extension = value["extension"]
        }
	end,
	OnGet = function(self, default)
        local connMetaData = self.vars.landlineConnection
        return connMetaData
	end,
    OnAdjust = function(self, client, data, value, newData)
		newData.landlineConnection = value
	end
})

do
    local phoneChatCommands = {
        phonesay = {
            alias = "PS",
            description = "Mów do telefonu, jeśli go trzymasz.",
            range = ix.config.Get("chatRange", 280),
        },
        phonewhisper = {
            alias = "PW",
            description = "Szepcz do telefonu, jeśli go trzymasz.",
            range = ix.config.Get("chatRange", 280) / 4,
        },
        phoneyell = {
            alias = "PY",
            description = "Krzycz do telefonu, jeśli go trzymasz.",
            range = ix.config.Get("chatRange", 280) * 4,
        }
    }

    for phoneChatCommand, commandSettings in pairs(phoneChatCommands) do
        ix.command.Add(phoneChatCommand, {
            alias = commandSettings.alias,
            description = commandSettings.description,
            arguments = ix.type.text,
            privilege = "Use Phones",
            OnRun = function(self, client, message)
                local character = client:GetCharacter()
                if (!istable(character)) then
                    return
                end
                if (character:GetLandlineConnection().active) then
                    local recvs = ix.phone.switch:GetCharacterActiveListeners(character)
                    if (!recvs) then
                        recvs = {}
                    end

                    local eavesDropRecvs = ix.phone.switch.endpoints:GetPlayersInRadiusFromPos(
                            client:GetPos(), commandSettings.range)

                    if (istable(eavesDropRecvs)) then
                        table.Add(recvs, eavesDropRecvs)
                    end

                    -- doing this here because, for some reason, chat CanHear just isn't working
                    -- "If you want it done right, do it yourself"
                    ix.chat.Send(client, phoneChatCommand, message, false, recvs)
                end
            end
        })
    end
end

do
    -- used to simulate a distortion effect on certain letters when using phoneyell
    local chatDistortionChars = {
        O = "Ő̸̗",
        F = "F̸̲̂̉ ̷̖̇̀",
        P = "P̵̧̝̫̘͛͜F̶̆̃ ̴̩̫̎̌͜͝ ̴͈̈́",
        CK =  "C̴̣̖̕͜K̵̘̲͂̈́",
        K = "K̵̘̲͂̈́",
        T = "T̸̮͒͝͝",
        X = "Ẍ̷̻́_̷̛̰",
        SH =  "S̷̥̓ ̶̖͂Ḣ̴̗ ̴̘̔",
        Z = "Z̶̗̒̃̅",
        S = "S̶͖̐̿ ̷̤̰͂͌",
        H = " ̵̬̻͇̎ ̵͈̦͍̔̅̊̇͝H"
    }
    -- TODO: get atle to add a real icon for this to willardcuntent
    local chatIcon = ix.util.GetMaterial("willardnetworks/chat/message_icon.png")
    local chatSettings = {
        phonewhisper = {
            range = ix.config.Get("chatRange", 280) / 4,
            color = Color(149, 196, 215),
            indicator = "chatWhispering",
            format = "[PHONE] %s: (whisper) \"%s\""
        },
        phonesay = {
            range = ix.config.Get("chatRange", 280),
            color = Color(105, 157, 178),
            indicator = "chatTalking",
            format = "[PHONE] %s: \"%s\""
        },
        phoneyell = {
            range = ix.config.Get("chatRange", 280) * 4,
            color = Color(166, 89, 89),
            indicator = "chatYelling",
            format = "[PHONE] %s: \"%s\""
        }
    }

    for chatType, chatTypeData in pairs(chatSettings) do
        ix.chat.Register(chatType, {
            color = chatTypeData.color,
            indicator = chatTypeData.indicator,
            format = chatTypeData.format,
            CanSay = function(self, speaker, text)
                return speaker:GetCharacter():GetLandlineConnection()["active"]
            end,
            OnChatAdd = function(self, speaker, text, anonymous, data)
                local name = anonymous and
				    L"someone" or
                    hook.Run("GetCharacterName", speaker, "ic") or
				    (IsValid(speaker) and speaker:Name() or "Console")

                local rText = ix.chat.Format(text)
                if (chatType == "phoneyell") then
                    rText = rText:upper()
                    for char, repl in pairs(chatDistortionChars) do
                        rText = rText:gsub(tostring(char), tostring(repl))
                    end

                    -- ix.chat.Format() will always add punctuation. 
                    -- Replace that with an exclamation mark for greater effect :)
                    rText = rText:sub(1, -2)
                    rText = rText.."!"
                end
                rText = string.format(chatTypeData.format, name, rText)

                if (ix.option.Get("standardIconsEnabled")) then
                    chat.AddText(chatIcon, self.color, rText)
                else
                    chat.AddText(self.color, rText)
                end
            end
        })
    end
end

do
    -- dial statuses which will be displayed on the target phone's derma
    ix.phone.switch.DialStatus = {
        SourceNotExist = "Err #186A0:>\n Source does not exist as a destination.\n Is it registered in the PSTN?",
        NoDialSeq = "Err #1D4C0:>\n No dial sequence provided.",
        CannotDecodeDial = "Err #1E078:>\n Invalid dial sequence provided.",
        NumberNotFound = "Err #1E208:>\n Destination not registered in the PSTN;\n Cannot find a route.",
        EndpointNotFound = "Err #1E23A:>\n Route exists, but is missing a valid endpoint;\n Cannot reach endpoint.",
        DebugMode = "Entering debug mode.",
        Success = "Connection established.",
        LineBusy = "Line busy. Please try again later",
        NotSetup = "Err #1E240:>\n Cannot establish connection.\n Please verifiy connection to PBX."
    }
end
