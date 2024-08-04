--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


surface.CreateFont("ImportantDisplayMessage", {
	font = "BudgetLabel",
	extended = false,
	size = SScaleMin(16 / 3),
	weight = 550,
	outline = true,
})

if (ix.item.base["base_weapons"]) then
	local ITEM = ix.item.base["base_weapons"]
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		end
	end
end

net.Receive("ixInvTypeSearchChoice", function()
	local options = {}
	options["Voir l'inventaire des équipements"] = function()
		net.Start("ixInvTypeSearchChoice")
		net.WriteString("eqInv")
		net.SendToServer()
	end

	options["Voir l'inventaire par défaut"] = function()
		net.Start("ixInvTypeSearchChoice")
		net.WriteString("normInv")
		net.SendToServer()
	end

	ix.menu.Open(options, false)
end)