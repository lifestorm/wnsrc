--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

function PLUGIN:PopulateEntityInfo(entity, container)
  local drop = entity:GetNetVar("drop")

  if (drop) then
		local corpseTooltip = container:AddRow("corpse")
    corpseTooltip:SetContentAlignment(5)
		corpseTooltip:SetText("Vous pouvez massacrer ce cadavre en le frappant avec le bon outil.")
		corpseTooltip:SizeToContents()
  end
end
