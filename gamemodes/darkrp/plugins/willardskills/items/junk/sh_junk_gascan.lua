--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "junk_gascan"
ITEM.name = "Boş Benzin Bidonu"
ITEM.description = "Yakıt veya benzeri bir şey taşımak için kullanılan boş bir gaz kutusu. Boş."
ITEM.category = "Junk"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
    pos = Vector(200, 0, 0),
    ang = Angle(0, 180, 0),
    fov = 6.48
}
ITEM.model = "models/props_junk/metalgascan.mdl"
ITEM.colorAppendix = {["blue"] = "Bu eşya, Zanaatkarlık becerisi ile temel bileşenlerine ayrılabilir."}
ITEM.holdData = {
    vectorOffset = {
        right = 3,
        up = -13,
        forward = 5
    },
    angleOffset = {
        right = 90,
        up = 90,
        forward = -0
    },
}
