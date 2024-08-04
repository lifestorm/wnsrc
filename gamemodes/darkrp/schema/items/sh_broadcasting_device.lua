--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Yayın Cihazı"
ITEM.model = Model("models/props_lab/reciever01b.mdl")
ITEM.description = "Şehre mesaj yayınlamak için kullanılan bir cihaz."
ITEM.KeepOnDeath = true
ITEM.category = "Combine"
ITEM.colorAppendix = {["red"] = "Bu öğeyi taşımak için personel izni gereklidir, düşürmeyin veya diğer oyunculara vermek için kullanmayın."}

if (CLIENT) then
    function ITEM:PaintOver(item, w, h)
        surface.SetDrawColor(255, 0, 0, 100)
        surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
    end
end