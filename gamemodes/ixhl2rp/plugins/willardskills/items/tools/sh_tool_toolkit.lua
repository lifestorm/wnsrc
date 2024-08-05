--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "tool_toolkit"
ITEM.name = "Toolkit"
ITEM.description = "A small metal crate containing various construction tools for assembling items."
ITEM.category = "Tools"
ITEM.model = "models/willardnetworks/skills/toolkit.mdl"
ITEM.maxDurability = 24
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-200, 0, 0),
  ang = Angle(-1.45, -0.07, 0),
  fov = 7.71
}
ITEM.holdData = {
  vectorOffset = {
      right = 1,
      up = -10,
      forward = 2
  },
  angleOffset = {
      right = 90,
      up = -15,
      forward = 90
  },
}

ITEM.functions.RepairObject = {
  name = "Repair Object",
  icon = "icon16/wrench.png",

  OnRun = function(itemTable)
    local client = itemTable.player
    local ent = client:GetEyeTraceNoCursor().Entity

    ix.malfunctions:Fix(ent, client)

    return false
  end,

  OnCanRun = function(itemTable)
    local client = itemTable.player
    local ent = client:GetEyeTraceNoCursor().Entity

    return ent:IsValid() and ent.canMalfunction and ent:GetNetVar("isBroken", false)
  end
}