--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Microphone sans fil"
ITEM.model = Model("models/props_junk/cardboard_box004a.mdl")
ITEM.description = "Un microphone qui est connecté sans fil aux systèmes de diffusion à proximité."
ITEM.KeepOnDeath = true
ITEM.category = "Combine"
ITEM.colorAppendix = {["red"] = "Vous devez obtenir l'autorisation du staff pour porter cet objet, ne le laissez pas tomber et ne le remettez pas aux autres joueurs."}

if (CLIENT) then
    function ITEM:PaintOver(item, w, h)
        surface.SetDrawColor(255, 0, 0, 100)
        surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
    end
end
