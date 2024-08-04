--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:OnContextMenuOpen()
	if (IsValid(self.ui.panel)) then
		self.ui.panel:MakePopup()
	end
end

function PLUGIN:OnContextMenuClose()
	if (IsValid(self.ui.panel)) then
		self.ui.panel:SetMouseInputEnabled(false)
		self.ui.panel:SetKeyboardInputEnabled(false)
	end
end
