--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Hafif Görev Üniforması"
ITEM.model = Model("models/wn7new/metropolice/cpuniform.mdl")
ITEM.description = "Sivil Koruma tarafından kullanılmak üzere tasarlanmış güzel ve temiz bir üniforma seti. Seviye-2 Kevlar yelek, yalıtımlı yeşil pantolon, çift çelik yardımcı kemer ve çelik başlıklı askeri botlar içerir."
ITEM.category = "Combine"
ITEM.replacementString = "wn7new/metropolice"
ITEM.model = "models/wn7new/metropolice/cpuniform.mdl"
ITEM.iconCam = {
  pos = Vector(-1.96, 13.01, 199.57),
  ang = Angle(84.7, 279.39, 0),
  fov = 4.8
}
ITEM.isCP = true

ITEM.channels = {"cmb", "tac-3"}

ITEM.bodyGroups = {
    ["Pants"] = 0,
    ["cp_Body"] = 2
}

ITEM.replaceOnDeath = "broken_cpuniform"
ITEM.energyConsumptionRate = 0.002 -- fatigue_system
