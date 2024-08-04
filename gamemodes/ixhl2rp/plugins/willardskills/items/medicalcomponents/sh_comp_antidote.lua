--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "antidote"
ITEM.name = "Antidotum"
ITEM.description = "Dziwaczna strzykawka wypełniona fioletowym płynem mogącym obniżyć poziom toksyn w organizmie."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/medx.mdl"
ITEM.colorAppendix = {["blue"] = "Ten przedmiot można stworzyć dzięki umiejętności Medycyny.", ["red"] = "Ten przedmiot może obniżyć ilość „gazu” w postaci."}
ITEM.useSound = "medicina/nmrih_syringe.ogg"

ITEM.functions.Use = {
    name = "Zastosuj",
    OnRun = function(item)
        local client = item.player
        local character = item.player:GetCharacter()

        client:EmitSound(item.useSound)

        if character:GetGasPoints() >= 120 then
            client:ChatNotifyLocalized("Wstrzykujesz antidotum do swojego ciała... jednak nie czujesz się inaczej. *Nie już nie mogę zrobić, to jest już właśnie koniec...*")
        elseif (character:GetGasPoints() - 45 <= 0) then
            character:SetGasPoints(0)
            client:ChatNotifyLocalized("Czujesz się teraz o wiele lepiej!")
        else
            character:SetGasPoints(character:GetGasPoints() - 45)
        end
    end
}