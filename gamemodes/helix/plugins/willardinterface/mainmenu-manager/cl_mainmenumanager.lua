--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


net.Receive("RequestMainMenuInfo", function()
	local list = net.ReadTable()
	local logoData = net.ReadTable()
	local buttonColors = net.ReadTable()

	if ix.gui.wnMainMenu and IsValid(ix.gui.wnMainMenu) then
		if ix.gui.wnMainMenu.CreateMainPanel then
			ix.gui.wnMainMenu:CreateMainPanel(logoData, buttonColors)

			if ix.gui.wnMainMenu.UpdateChildPanels and ix.gui.wnMainMenu.GetParent then
				local parent = ix.gui.wnMainMenu:GetParent()
				if parent and IsValid(parent) then
					ix.gui.wnMainMenu:UpdateChildPanels(parent)
				end
			end
		end
	end

	if #list <= 0 then
		list = {"city_bg"}
	end

	ix.gui.background_url = "willardnetworks/backgrounds/"..table.Random(list)..".jpg"

	if !ix.gui.mainMenuManager or ix.gui.mainMenuManager and !IsValid(ix.gui.mainMenuManager) then
		return
	end

	if !ix.gui.mainMenuManager.PopulateBackgroundList then return end
	if !list or list and !istable(list) then return end

	ix.gui.mainMenuManager:PopulateBackgroundList(list)

	if !ix.gui.mainMenuManager.PopulateColors then return end
	ix.gui.mainMenuManager:PopulateColors(buttonColors)
end)