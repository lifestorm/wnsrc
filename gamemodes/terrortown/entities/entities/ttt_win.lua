--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ENT.Type = "point"
ENT.Base = "base_point"

function ENT:AcceptInput(name, activator, caller)
   if name == "TraitorWin" then
      GAMEMODE:MapTriggeredEnd(WIN_TRAITOR)
      return true
   elseif name == "InnocentWin" then
      GAMEMODE:MapTriggeredEnd(WIN_INNOCENT)
      return true
   end
end