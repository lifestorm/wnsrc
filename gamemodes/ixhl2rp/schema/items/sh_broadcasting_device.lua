--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Urządzenie nadawcze"
ITEM.model = Model("models/props_lab/reciever01b.mdl")
ITEM.description = "Urządzenie służące do nadawania transmisji na całe miasto."
ITEM.KeepOnDeath = true
ITEM.category = "Combine"
ITEM.colorAppendix = {["red"] = "Potrzebujesz pozwolenia administracji serwera aby nosić ten przedmiot. Nie wyrzucaj i nie przekazuj go innym graczom."}

if (CLIENT) then
    function ITEM:PaintOver(item, w, h)
        surface.SetDrawColor(255, 0, 0, 100)
        surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
    end
end