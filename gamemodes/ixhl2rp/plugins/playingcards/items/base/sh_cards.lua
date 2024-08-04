--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.base = "base_stackable"
ITEM.name = "Karty do gry"
ITEM.model = Model("models/cards/card1.mdl")
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 1.12
}
ITEM.category = "Playing Cards"
ITEM.maxStackSize = 10
ITEM.altCard = false
ITEM.color = Color(255, 255, 255) -- I'm just doing this to enable advanced rendering. I spent hours trying to get them to look right with normal icons, I'm about to go crazy. 

function ITEM:GetModel()
	return self.altCard and "models/cards/card2.mdl" or "models/cards/card1.mdl"
end

function ITEM:GetDescription()
	return "Karta do gry oznaczona jako " .. self.name .. ". Jest delikatnie wygładzona na rogach, aby ułatwić użytkowanie.."
end

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local itemEntity = self.entity
		if (!itemEntity or !IsValid(itemEntity)) then return end

		local entPos = itemEntity:GetPos()
		local up = itemEntity:GetUp()
		local posBack, posForward = entPos + up * -5, entPos + up * 5
		local eyePos = EyePos()
		local distanceForward, distanceBack = eyePos:DistToSqr(posForward), eyePos:DistToSqr(posBack)
		
		local name = tooltip:GetRow("name")
		local description = tooltip:GetRow("description")

		if (distanceForward > distanceBack) then
			name:SetText("Karta do gry")
			name:SizeToContents()
			description:SetText("Zwykła karta do gry.")
			description:SizeToContents()
		end
	end
end
