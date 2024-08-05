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
ITEM.name = "Antidote"
ITEM.description = "A strange syringe filled with purple liquid can reduce toxin levels in your body.."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/medx.mdl"
ITEM.colorAppendix = {["blue"] = "This item can be made through the Medical skill.", ["red"] = "This item can lower the amount of 'Gas' your character has."}
ITEM.useSound = "medicina/nmrih_syringe.ogg"

ITEM.functions.Use = {
    name = "Apply",
    OnRun = function(item)
        local client = item.player
        local character = item.player:GetCharacter()

        client:EmitSound(item.useSound)
        
        if character:GetGasPoints() >= 120 then 
            client:ChatNotifyLocalized("You inject the antidote in your body... but don't feel any different. *There's nothing else to be done, this is it for me...*")
        elseif (character:GetGasPoints() - 45 <= 0) then 
            character:SetGasPoints(0) 
            client:ChatNotifyLocalized("You feel a lot better now!")
        else 
            character:SetGasPoints(character:GetGasPoints() - 45) 
        end 
    end
}