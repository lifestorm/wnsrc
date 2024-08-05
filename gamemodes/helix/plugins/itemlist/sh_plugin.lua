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

PLUGIN.name = "Itemlist"
PLUGIN.author = "Zombine, ported by Fruity"
PLUGIN.description = "Adds a spawn-menu tab with all registered items listed by category."

CAMI.RegisterPrivilege({
	Name = "Helix - Item Menu",
	MinAccess = "superadmin"
})

if (SERVER) then
	netstream.Hook("MenuItemSpawn", function(client, uniqueID)
		if (!IsValid(client)) then return end
		if (!CAMI.PlayerHasAccess(client, "Helix - Item Menu")) then return end

		local pos = client:GetEyeTraceNoCursor().HitPos

		ix.item.Spawn(uniqueID, pos + Vector( 0, 0, 10 ))
		ix.log.Add(client, "itemListSpawnedItem", uniqueID)

		hook.Run("PlayerSpawnedItem", client, pos, uniqueID)
	end)

	netstream.Hook("MenuItemGive", function(client, uniqueID)
		if (!IsValid(client)) then return end
		if (!CAMI.PlayerHasAccess(client, "Helix - Item Menu")) then return end

		local character = client:GetCharacter()
		local inventory = character:GetInventory()

		inventory:Add(uniqueID, 1)
		ix.log.Add(client, "itemListGiveItem", uniqueID)

		hook.Run("PlayerGaveItem", client, client:GetCharacter(), uniqueID, 1)
	end)

	function PLUGIN:PlayerLoadedCharacter(client)
		netstream.Start(client, "CheckForItemTab")
	end

	ix.log.AddType("itemListSpawnedItem", function(client, name)
		return string.format("%s has spawned a %s.", client:GetName(), name)
	end)
	ix.log.AddType("itemListGiveItem", function(client, name)
		return string.format("%s has given himself a %s.", client:GetName(), name)
	end)
else
	local icons = {
		["Ammunition"] = "box",
		["Ammunition (New)"] = "box",
		["Clothing"] = "user_suit",
		["Combine"] = "contrast",
		["Food"] = "cake",
		["Ingredient"] = "basket",
		["Workbenches"] = "page",
		["Crafting"] = "cog",
		["Deployables"] = "arrow_down",
		["Filters"] = "weather_clouds",
		["Junk"] = "bin",
		["Medical"] = "heart",
		["Medicine Components"] = "heart_add",
		["Drugs"] = "rainbow",
		["Melee Weapons"] = "bomb",
		["Other"] = "brick",
		["Storage"] = "package",
		["Tools"] = "wrench",
		["Weapons"] = "gun",
		["Attachment"] = "gun",
		["Technology"] = "computer",
		["Water Loot"] = "weather_rain",
		["Writing"] = "book_open",
		["Vortigaunt"] = "bug",
		["Xen"] = "world",
		["Audiobooks"] = "music",
		["Housing"] = "house",
		["Infestation Control"] = "wand"
	}

	spawnmenu.AddContentType("ixItem", function(container, data)
		if (!data.name) then return end

		local icon = vgui.Create("ContentIcon", container)

		icon:SetContentType("ixItem")
		icon:SetSpawnName(data.uniqueID)
		icon:SetName(L(data.name))

		icon.model = vgui.Create("ModelImage", icon)
		icon.model:SetMouseInputEnabled(false)
		icon.model:SetKeyboardInputEnabled(false)
		icon.model:StretchToParent(16, 16, 16, 16)
		icon.model:SetModel(data:GetModel(), data:GetSkin(), "000000000")
		icon.model:MoveToBefore(icon.Image)

		function icon:DoClick()
			netstream.Start("MenuItemSpawn", data.uniqueID)
			surface.PlaySound("ui/buttonclickrelease.wav")
		end

		function icon:OpenMenu()
			local menu = DermaMenu()
			menu:AddOption("Copy Item ID to Clipboard", function()
				SetClipboardText(data.uniqueID)
			end)

			menu:AddOption("Give to Self", function()
				netstream.Start("MenuItemGive", data.uniqueID)
			end)

			if (data.customItem) then
				menu:AddOption("Delete Item", function()
					net.Start("ixDeleteCustomItem")
						net.WriteString(data.uniqueID)
					net.SendToServer()
				end)
			end

			menu:Open()

			for _, v in pairs(menu:GetChildren()[1]:GetChildren()) do
				if v:GetClassName() == "Label" then
					v:SetFont("MenuFontNoClamp")
				end
			end
		end

		if ix.gui.clothingCreator and IsValid(ix.gui.clothingCreator) then
			icon.DoClick = function()
				surface.PlaySound( "ui/buttonclickrelease.wav")
				ix.gui.clothingCreator:SaveItemMenuChoice(data.uniqueID)
			end

			icon.OpenMenu = function() end
		end

		if (IsValid(container)) then
			container:Add(icon)
		end
	end)

	spawnmenu.AddContentType("ixItemAdvanced", function(container, data)
		if (!data.name) then return end

		local icon = vgui.Create("ContentIcon", container)

		icon:SetContentType("ixItem")
		icon:SetSpawnName(data.uniqueID)
		icon:SetName(L(data.name))

		icon.model = vgui.Create("ixItemIconAdvanced", icon)
		icon.model:SetMouseInputEnabled(false)
		icon.model:SetKeyboardInputEnabled(false)
		icon.model:StretchToParent(16, 16, 16, 16)
		icon.model:SetModel(data:GetModel(), data:GetSkin(), "000000000")
		icon.model:MoveToBefore(icon.Image)

		local entity = icon.model:GetEntity()
		icon.model:SetColor(color_white)

		if (data.OnInventoryDraw) then
			data.OnInventoryDraw(data, entity)
		end

		if (data.iconCam) then
			icon.model:SetCamPos(data.iconCam.pos)
			icon.model:SetFOV(data.iconCam.fov)
			icon.model:SetLookAng(data.iconCam.ang)
		else
			local pos = entity:GetPos()
			local camData = PositionSpawnIcon(entity, pos)

			if (camData) then
				icon.model:SetCamPos(camData.origin)
				icon.model:SetFOV(camData.fov)
				icon.model:SetLookAng(camData.angles)
			end
		end

		icon.model.LayoutEntity = function() end

		function icon:DoClick()
			netstream.Start("MenuItemSpawn", data.uniqueID)
			surface.PlaySound("ui/buttonclickrelease.wav")
		end

		function icon:OpenMenu()
			local menu = DermaMenu()
			menu:AddOption("Copy Item ID to Clipboard", function()
				SetClipboardText(data.uniqueID)
			end)

			menu:AddOption("Give to Self", function()
				netstream.Start("MenuItemGive", data.uniqueID)
			end)

			if (data.customItem) then
				menu:AddOption("Delete Item", function()
					net.Start("ixDeleteCustomItem")
						net.WriteString(data.uniqueID)
					net.SendToServer()
				end)
			end

			menu:Open()

			for _, v in pairs(menu:GetChildren()[1]:GetChildren()) do
				if v:GetClassName() == "Label" then
					v:SetFont("MenuFontNoClamp")
				end
			end
		end

		if ix.gui.clothingCreator and IsValid(ix.gui.clothingCreator) then
			icon.DoClick = function()
				surface.PlaySound( "ui/buttonclickrelease.wav")
				ix.gui.clothingCreator:SaveItemMenuChoice(data.uniqueID)
			end

			icon.OpenMenu = function() end
		end

		if (IsValid(container)) then
			container:Add(icon)
		end
	end)

	function PLUGIN:CreateItemsPanel()
		local base = vgui.Create("SpawnmenuContentPanel")
		local tree = base.ContentNavBar.Tree
		local categories = {}

		vgui.Create("ItemSearch", base.ContentNavBar)

		for _, v in SortedPairsByMemberValue(ix.item.list, "category") do
			if (!categories[v.category] and not string.match( v.name, "Base" )) then
				categories[v.category] = true

				local category = tree:AddNode(v.category, icons[v.category] and ("icon16/" .. icons[v.category] .. ".png") or "icon16/brick.png")

				category.DoPopulate = function()
					if (category.Container) then return end

					category.Container = vgui.Create("ContentContainer", base)
					category.Container:SetVisible(false)
					category.Container:SetTriggerSpawnlistChange(false)


					for _, itemTable in SortedPairsByMemberValue(ix.item.list, "name") do
						if (itemTable.category == v.category and not string.match( itemTable.name, "Base" )) then
							if itemTable.base == "base_bgclothes" then
								spawnmenu.CreateContentIcon("ixItemAdvanced", category.Container, itemTable)
							else
								spawnmenu.CreateContentIcon("ixItem", category.Container, itemTable)
							end
						end
					end
				end

				category.DoClick = function()
					category:DoPopulate()
					base:SwitchPanel(category.Container)
				end
			end
		end

		local FirstNode = tree:Root():GetChildNode(0)

		if (IsValid(FirstNode)) then
			FirstNode:InternalDoClick()
		end

		PLUGIN:PopulateContent(base, tree, nil)

		local refresh = base.ContentNavBar:Add("DButton")
		refresh:Dock(BOTTOM)
		refresh:DockMargin(0, 10, 0, 0)
		refresh:SetText("Refresh")
		refresh.Paint = function(this, width, height)
			surface.SetDrawColor(0, 0, 0, 150)
			surface.DrawRect(0, 0, width, height)
		end
		refresh.DoClick = function()
			LocalPlayer():ConCommand("spawnmenu_reload")
		end

		return base
	end

	spawnmenu.AddCreationTab("Items", PLUGIN.CreateItemsPanel, "icon16/script_key.png")

	netstream.Hook("CheckForItemTab", function()
		if !LocalPlayer():GetNWBool("spawnmenu_reloaded") then
			LocalPlayer():ConCommand( "spawnmenu_reload" )

			LocalPlayer():SetNWBool("spawnmenu_reloaded", true)
		end
	end)
end
