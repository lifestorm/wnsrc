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
PLUGIN.name = "Automatic Chat Messages"
PLUGIN.author = "M!NT"
PLUGIN.description = "Makes some actions automatically appear in chat as actions."

ix.config.Add("autoChatMessages", true, "Whether or not to display automatic chat messages.", nil, {
    category = "chat"
})

ix.option.Add("showAutomaticActionsInChat", ix.type.bool, true, {
    category = "chat"
})

ix.lang.AddTable("english", {
    optShowAutomaticActionsInChat = "Show automatic actions in chat",
    optdShowAutomaticActionsInChat = "Whether or not to display automatic chat messages.",
    -- TODO: add this for the chat types too (?)
})

ix.autochat = ix.autochat or {}

ix.autochat.iconDefault = ix.util.GetMaterial("willardnetworks/chat/whisper_icon.png")
ix.autochat.colorDefault = Color(214, 254, 137, 255)
ix.autochat.colorAltDefault = Color(218, 249, 160)

ix.autochat.types = {
    ["WEAPON_RAISE_FISTS"] = {
        text = {
            " raises their fists, ready to fight.",
            " raises their fists, preparing for a fist fight.",
            " squares up, raising their fists in preparation for a fight."
        },
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_orange.png"),
        color = Color(255, 172, 95),
        colorAlt = Color(255, 207, 95)
    },
    ["WEAPON_RAISE_MELEE"] = {
        text = " raises their weapon.",
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_orange.png"),
        color = Color(255, 172, 95),
        colorAlt = Color(255, 207, 95)
    },
    ["WEAPON_RAISE_GUN"] = {
        text = " raises their weapon and aims down the sights.",
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_orange.png"),
        color = Color(255, 172, 95),
        colorAlt = Color(255, 207, 95)
    },
    ["WEAPON_FIRE_START"] = {
        text = {
            " squeezes the trigger, firing a round at the target in their sights.",
            " pulls the trigger, firing rounds at their intended target.",
            " shoots their their weapon, firing towards their intended target.",
            " rapidly squeezes down onto the firearm's trigger, sending a flurry of live ammunition towards their intended target."
        },
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_red.png"),
        color = Color(193, 63, 63),
        colorAlt = Color(255, 88, 58)
    },
    ["WEAPON_MELEE_START"] = {
        text = { " begins to attack their intended target with the weapon in their hands." },
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_red.png"),
        color = Color(193, 63, 63),
        colorAlt = Color(255, 88, 58)
    },
    --[[ TODO: implement these
    ["WEAPON_VORTBEAM_START"] = {
        text = { "fires a beam of vortalenergy from between their hands at their intended target." },
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_red.png"),
        color = Color(193, 63, 63),
        colorAlt = Color(255, 88, 58)
    },
    ["WEAPON_VORTSLAM_START"] = {
        text = { "slams the ground with a blast of vortal energy." },
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_red.png"),
        color = Color(193, 63, 63),
        colorAlt = Color(255, 88, 58)
    },
    ]]
    ["WEAPON_LOWER"] = {
        text = " lowers their weapon.",
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_orange.png"),
        color = Color(237, 207, 139),
        colorAlt = Color(237, 178, 139),
    },
    ["WEAPON_LOWER_FISTS"] = {
        text = " lowers their fists.",
        icon = ix.util.GetMaterial("willardnetworks/chat/gun_orange.png"),
        color = Color(237, 207, 139),
        colorAlt = Color(237, 178, 139),
    },
    ["ENTER_BLEEDOUT"] = {
        text = {
            " has been critically injured and is now bleeding out.",
            " is critically injured and falls to the ground limp.",
            " falls to the ground, critically injured and bleeding out.",
            " is critically injured and falls to the ground, bleeding out.",
            " succumbs to their injuries and falls to the ground."
        },
    },
    ["DRUNK_FALL_OVER"] = {
        text = {
            " sank to the ground, the cool floor offering an unexpected but welcome place to rest..",
            " staggered sideways, and in a drunken haze, collapsed onto the ground..",
            " swayed unsteadily, then in a tipsy blur, tumbled face-first to the floor.",
            " zigzagged forward, and in a boozy misstep, performed a perfect face-first dive onto the floor.",
            " wobbled sideways, then in a drunken pirouette, executed a flawless face-first splat on the floor.",
            " staggered forward, and in an alcohol-fueled acrobatic fail, face-planted spectacularly onto the ground."
        },
    },
    ["CONTAINER_OPEN"] = { text = " opens the 'X' container." },
    ["MEDICAL_BANDAGE"] = {
        text = {
            " applies a bandage to their bleeding wounds.",
            " wraps a bandage around their bleeding wounds.",
            " applies a bandage to their wounds.",
        }
    },
    ["DRUG_INJECT"] = { text = " injects themselves with a drug." },
    ["SEARCH_TRASH"] = { text = " searches through the trash bags for anything of interest."},
}

do
    local CLASS = {}
    if (CLIENT) then
        function CLASS:OnChatAdd(speaker, text, anonymous, data)
            if (!data.autochatType) then return end
            local _type = ix.autochat.types[data.autochatType]
            if (!_type) then return end

            text = _type.text
            if (!text) then return end

            if (istable(text)) then
                text = text[math.random(1, #text)]
            end

            if (text:find("X") and data.sub) then
                text = text:gsub("X", data.sub)
            end

            local color, colorAlt
            if (!_type.color) then
                color = ix.autochat.colorDefault
                color = ix.autochat.colorAltDefault
            else
                color = _type.color
                colorAlt = _type.colorAlt
            end

            local icon = _type.icon
            local prefix = icon and "> " or "** > "
            local bToYou = speaker and IsValid(speaker) and speaker:GetEyeTraceNoCursor().Entity == LocalPlayer()
            local finalColor = bToYou and colorAlt or color

            local name = hook.Run("GetCharacterName", speaker, "ic") or
                (IsValid(speaker) and speaker:Name() or "Console")

            local finalText = prefix..name..text
            if (ix.option.Get("showAutomaticActionsInChat")) then
                if (icon) then
                    chat.AddText(icon, finalColor, finalText)
                else
                    chat.AddText(finalColor, finalText)
                end
            else
                MsgC(finalColor, finalText, "\n")
            end
        end

    end
    ix.chat.Register("autochat_message", CLASS)
end

if (SERVER) then
    do
        for k, v in pairs(ix.item.list) do
            if (!v.healing) then continue end

            if (!v.functions.use or !v.functions.use.OnRun) then continue end

            if (v.autochatOverrideExists) then
                continue
            end

            -- sneaky way to override the use function of items:
            local _oldUse = v.functions.use.OnRun
            v.functions.use.OnRun = function(item)
                local client = item.player
                if (!client) then ErrorNoHaltWithStack("Attempt to use item without a valid player! (wtf?)") return end

                if (item.healing.bandage) then
                    ix.chat.Send(client, "autochat_message", "", false, ix.autochat:GetRecievers(client), {
                        autochatType = "MEDICAL_BANDAGE"
                    })
                end

                return _oldUse(item)
            end

            v.autochatOverrideExists = true
        end

        local contTbl = scripted_ents.GetStored("ix_wncontainer")
        if (!contTbl or !istable(contTbl)) then return end
        if (!contTbl.t or !istable(contTbl.t)) then return end

        local _oldFunc = contTbl.t.OpenInventory
        function contTbl.t:OpenInventory(activator)
            if (!activator or !IsValid(activator)) then return end

            _oldFunc(self, activator)

            ix.chat.Send(activator, "autochat_message", "", false, ix.autochat:GetRecievers(activator), {
                autochatType = "CONTAINER_OPEN",
                sub = self:GetDisplayName()
            })
        end

        local trashTbl = scripted_ents.GetStored("ix_garbage")
        if (!trashTbl or !istable(trashTbl)) then return end
        if (!trashTbl.t or !istable(trashTbl.t)) then return end

        local _oldUse = trashTbl.t.Use
        function trashTbl.t:Use(activator, caller)
            if (!activator or !IsValid(activator)) then return end
            local shouldSend = self.alive
            _oldUse(self, activator, caller)

            if (shouldSend) then
                ix.chat.Send(activator, "autochat_message", "", false, ix.autochat:GetRecievers(activator), {
                    autochatType = "SEARCH_TRASH"
                })
            end
        end

        local _oldSetBleedout = ix.meta.character.SetBleedout
        function ix.meta.character:SetBleedout(value)
            _oldSetBleedout(self, value)

            local client = self:GetPlayer()
            if (value > 0) then
                if (client.ixAutochatBleedoutSent) then return end
                if (client and IsValid(client)) then
                    ix.chat.Send(client, "autochat_message", "", false, ix.autochat:GetRecievers(client), {
                        autochatType = "ENTER_BLEEDOUT"
                    })
                end
                client.ixAutochatBleedoutSent = true

                hook.Run("CharacterEnterBleedout", self)
            else
                client.ixAutochatBleedoutSent = nil
            end
        end
    end

    function PLUGIN:EntityFireBullets(ent, data)
        if (ent and IsValid(ent) and ent:IsPlayer()) then
            ix.autochat:FireBullets(ent, "WEAPON_FIRE_START")
        end
    end

    function ix.autochat:GetRecievers(client)
        local entsInside = ents.FindInSphere(client:GetPos(), ix.config.Get("chatRange", 280))
        local res = {}

        for _, _ent in ipairs(entsInside) do
            if (_ent:IsPlayer() and _ent.GetCharacter and _ent:GetCharacter()) then
                table.insert(res, _ent)
            end
        end

        return res
    end

    function ix.autochat:FireBullets(client, _type)
        if (!client or !IsValid(client) or !client:IsPlayer()) then return end

        if (client.ixShouldFireAutoChat and client.ixShouldFireAutoChat != false) then
            client.ixShouldFireAutoChat = false
            if (self:IsFiringMelee(client)) then
                _type = "WEAPON_MELEE_START"
            end
            ix.chat.Send(client, "autochat_message", "", false, ix.autochat:GetRecievers(client), {
                autochatType = _type
            })
        end
    end

    function ix.autochat:IsFiringMelee(client)
        if (!client or !IsValid(client) or !client:IsPlayer()) then return end

        local wep = client:GetActiveWeapon()
        if (!wep or !IsValid(wep)) then return end

        local cls = wep:GetClass()
        if (string.StartsWith(cls, "tfa") and !string.StartsWith(cls, "tfa_csgo")) then
            return true
        end
        if (wep.DamageType and wep.DamageType != DMG_BULLET and wep.DamageType != DMG_BUCKSHOT) then
            return true
        end

        return false
    end

    function ix.autochat:IsProbablyHoldingAGun(client)
        if (!client or !IsValid(client) or !client:IsPlayer()) then return end

        local wep = client:GetActiveWeapon()
        if (!wep or !IsValid(wep)) then return end

        if (wep.DamageType and wep.DamageType == DMG_BULLET) then
            return true
        end

        return false
    end

    timer.Simple(1, function()
        local meta = FindMetaTable("Player")

        if (!meta or !meta.ToggleWepRaised) then return end

        local _oldToggleWepRaised = meta.ToggleWepRaised
        function meta:ToggleWepRaised()
            _oldToggleWepRaised(self)

            local _type

            if (self:IsWepRaised()) then
                self.ixShouldFireAutoChat = true

                if (ix.autochat:IsProbablyHoldingAGun(self)) then
                    _type = "WEAPON_RAISE_GUN"
                else
                    _type = "WEAPON_RAISE_MELEE"
                end

                if (self:GetActiveWeapon():GetClass() == "ix_hands") then
                    _type = "WEAPON_RAISE_FISTS"
                end
            else
                self.ixShouldFireAutoChat = false
                _type = "WEAPON_LOWER"

                if (self:GetActiveWeapon():GetClass() == "ix_hands") then
                    _type = "WEAPON_LOWER_FISTS"
                end
            end

            ix.chat.Send(self, "autochat_message", "", false, ix.autochat:GetRecievers(self), { autochatType = _type })
        end
    end)
end
