--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]



net.Receive(StormFox2.Net.Texture, function(len, ply)
	StormFox2.Permission.EditAccess(ply,"StormFox Settings", function()
		StormFox2.Map.ModifyMaterialType( net.ReadString(), net.ReadInt( 3 ))
	end)
end)
