--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Wireless Microphone"
ITEM.model = Model("models/props_junk/cardboard_box004a.mdl")
ITEM.description = "A microphone that is wirelessly connected to nearby broadcasting systems."
ITEM.KeepOnDeath = true
ITEM.category = "Combine"
ITEM.colorAppendix = {["red"] = "You need permission from staff to carry this item, do not drop or hand it to other players."}

if (CLIENT) then
    function ITEM:PaintOver(item, w, h)
        surface.SetDrawColor(255, 0, 0, 100)
        surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
    end
end
