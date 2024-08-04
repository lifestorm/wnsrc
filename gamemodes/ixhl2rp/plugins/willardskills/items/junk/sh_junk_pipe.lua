--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "junk_pipe"
ITEM.name = "Cienka metalowa rura"
ITEM.description = "Nędzna metalowa rura. Nie jest przydatna jako broń."
ITEM.category = "Junk"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
    pos = Vector(-330.46, -276.42, 197.81),
    ang = Angle(25, 400, 0),
    fov = 2.37
  }  
ITEM.model = "models/props_canal/mattpipe.mdl"
ITEM.colorAppendix = {["blue"] = "Ten przedmiot może zostać rozłożony na części pierwsze przy pomocy umiejętności Wytwarzania."}
ITEM.holdData = {
    vectorOffset = {
        right = 0.5,
        up = -1.5,
        forward = 0
    },
    angleOffset = {
        right = 180,
        up = 0,
        forward = -0
    },
}