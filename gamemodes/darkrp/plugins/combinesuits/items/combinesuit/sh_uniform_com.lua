--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Orta Komuta Üniforması"
ITEM.model = Model("models/wn7new/metropolice/cpuniform.mdl")
ITEM.description = "Orijinal Seviye-2 Kevlar yeleğinin değiştirilmiş bir versiyonunu içeren, Rütbe Liderleri ve üstü için tasarlanmış bir üniforma. Standart tasarıma kıyasla daha iyi konfor ve kullanışlılık sağlar."
ITEM.category = "Combine"
ITEM.replacementString = "wn7new/metropolice"
ITEM.model = "models/wn7new/metropolice/cpuniform.mdl"
ITEM.iconCam = {
  pos = Vector(-1.96, 13.01, 199.57),
  ang = Angle(84.7, 279.39, 0),
  fov = 4.8
}
ITEM.isCP = true
ITEM.maxArmor = 75

ITEM.channels = {"cmb", "tac-3", "tac-4", "tac-5"}

ITEM.bodyGroups = {
    ["Pants"] = 0,
    ["cp_Body"] = 16
}

ITEM.replaceOnDeath = "broken_cpuniform"
ITEM.energyConsumptionRate = 0.003 -- fatigue_system