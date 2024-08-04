--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


net.Receive("toggleBuildingNest", function()
	LocalPlayer().isBuildingNest = net.ReadBool()
end)

local blocked = {}

net.Receive("BirdMountRequest", function()
	local client = net.ReadEntity()

	if (blocked[client]) then
		net.Start("BirdMountDecline")
		net.SendToServer()

		return
	end

	local name = hook.Run("GetCharacterName", client, "ic") or client:GetName()
	local panel = Derma_Query(name .. " tente de se poser sur vous. Vous le laissez ?", "Requête d'oiseau",
	"Autoriser", function()
		net.Start("BirdMountAllow")
		net.SendToServer()
	end,
	"Refuser", function()
		net.Start("BirdMountDecline")
		net.SendToServer()
	end,
	"Bloquer", function()
		net.Start("BirdMountDecline")
		net.SendToServer()
		
		blocked[client] = true
	end)
	
	timer.Simple(30, function()
		if (IsValid(panel)) then
			panel:Remove()
			
			net.Start("BirdMountTimeout")
			net.SendToServer()
		end
	end)
end)

net.Receive("birdEggHatch", function()
	vgui.Create("ixbirdEggHatch")
end)
