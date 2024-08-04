--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Mikrofon bezprzewodowy"
ITEM.model = Model("models/props_junk/cardboard_box004a.mdl")
ITEM.description = "Mikrofon bezprzewodowo podłączony do najbliższego systemu nadawczego."
ITEM.KeepOnDeath = true
ITEM.category = "Combine"
ITEM.colorAppendix = {["red"] = "Potrzebujesz pozwolenia administracji serwera aby nosić ten przedmiot. Nie wyrzucaj i nie przekazuj go innym graczom."}

if (CLIENT) then
    function ITEM:PaintOver(item, w, h)
        surface.SetDrawColor(255, 0, 0, 100)
        surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
    end
end
