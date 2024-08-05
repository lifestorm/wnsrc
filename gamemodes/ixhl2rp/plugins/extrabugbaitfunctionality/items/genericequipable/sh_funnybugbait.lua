--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Pheropod"
ITEM.description = "A squishy heap of flesh shaped like a ball with small protrusions. Squeezing it releases a small cloud which has an interesting smell."
ITEM.model = Model("models/weapons/w_bugbait.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.colorAppendix = {["red"] = "This item is extremely powerful and requires Balance Team Lead approval to be spawned in."}

function ITEM:OnEquipped(client)
  local classtbl = {"CLASS_ANTLION"}
  client.VJ_NPC_Class = classtbl
end

function ITEM:OnUnequipped(client)
  local classtbl = {}
  client.VJ_NPC_Class = classtbl
end