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
PLUGIN.apartments = PLUGIN.apartments or {}

-- A function to get an apartment name
function PLUGIN:SetApartmentNames(tApartments)
	for _, ent in pairs(ents.GetAll()) do
		if !ent:GetClass():find("door") then continue end
		ent.doorName = nil
		ent.doorType = nil

		for _, tInfo in pairs(tApartments) do
			for _, doorIndex in pairs(tInfo.doors) do
				if doorIndex == ent:EntIndex() then
					ent.doorName = tInfo.name
					ent.doorType = tInfo.type
				end
			end
		end
	end
end

function PLUGIN:GetApartmentName(appID)
	netstream.Start("RequestApartmentNames", appID)
end

function PLUGIN:GetApartmentNameDatafile(appID)
	netstream.Start("RequestApartmentNamesDatafile", appID)
end

function PLUGIN:InitPostEntity()
	netstream.Start("RequestApartmentNames")
end

function PLUGIN:ConvertStringRequestToComboselect(requestPanel, comboValue, comboPopulate, callback)
	for i = 1, 2 do
		requestPanel:GetChildren()[5]:GetChildren()[i]:Remove()
	end

	local comboBox = requestPanel:Add("DComboBox")
	comboBox:SetValue(comboValue or "")
	comboBox:SetFont("MenuFontNoClamp")
	comboBox:Dock(TOP)
	comboBox:SetTall(SScaleMin(30 / 3))
	comboBox:DockMargin(0, SScaleMin(20 / 3), 0, 0)
	comboBox.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	comboPopulate(comboBox)

	requestPanel:GetChildren()[6]:GetChildren()[1].DoClick = function()
		callback(comboBox)
		requestPanel:Close()
	end

	requestPanel.Think = function(this)
		if IsValid(comboBox.Menu) and comboBox.Menu:IsVisible() then return end
		this:MoveToFront()
	end
end

-- A function to register the apartments ESP
do
	local priColor = Color(191, 91, 81, 255)
	local shopColor = Color(193, 136, 79, 255)
	local normColor = Color(185, 122, 87, 255)
	local center = TEXT_ALIGN_CENTER
    local function apartmentsESP(client, entity, x, y, factor)
		if !entity.doorName or !entity.doorType then return end

		local type = entity.doorType
		local espcol = (type == "priorytetowy" and priColor or type == "shop" and shopColor or normColor)
        ix.util.DrawText("APP: "..entity.doorName.." | "..string.upper(entity.doorType), x, y - math.max(10, 32 * factor), espcol, center, center, nil, math.max(255 * factor, 80))
    end

    ix.observer:RegisterESPType("func_door", apartmentsESP, "apartments")
	ix.observer:RegisterESPType("func_door_rotating", apartmentsESP, "apartments")
	ix.observer:RegisterESPType("prop_door_rotating", apartmentsESP, "apartments")
	ix.observer:RegisterESPType("prop_dynamic", apartmentsESP, "apartments")
end

-- Clientside hook to Sync App names, types and doors (for ESP)
netstream.Hook("SyncApartments", function(tApartments, bNoSetNames, bDatafile)
	for appID, tApartment in pairs(tApartments) do
		if PLUGIN.apartments[appID] then continue end

		PLUGIN.apartments[appID] = tApartment
	end

	if !bNoSetNames then
		PLUGIN:SetApartmentNames(tApartments)
	end

	if !bDatafile then return end
	if IsValid(ix.gui.datafileHousingInfo) and ix.gui.datafileHousingInfo.CreateHousingRow then
		ix.gui.datafileHousingInfo:CreateHousingRow(tApartments)
	end
end)

netstream.Hook("SyncApartmentsToDatapad", function(tApartments)
	PLUGIN.apartments = tApartments
	if !IsValid(ix.gui.apartments) then return end
	if !ix.gui.apartments.CreateApartments then return end

	if !tApartments or tApartments and !istable(tApartments) then return end
	if #tApartments == 0 then
		ix.gui.apartments.curCollect = ix.gui.apartments.curCollect - 5
		return
	end
	
	ix.gui.apartments:ClearContent()

	local normalHousing = {}
	local shops = {}

	for _, tApartment in pairs(tApartments) do
		local appID = tApartment.appID or 1

		if tApartment.type == "shop" then
			shops[appID] = tApartment
			continue
		end

		normalHousing[appID] = tApartment
	end

	ix.gui.apartments:CreateApartments(normalHousing, function(panel, combineutilities)
		panel:Dock(TOP)
		panel:SetTall(ix.gui.apartments:GetParent():GetTall() * 0.5 - ix.gui.apartments.apartmentsFrame:GetTall())
		panel:DockMargin(0, 0, 0, SScaleMin(10 / 3))

		ix.gui.apartments.shopsFrame = ix.gui.apartments:Add("EditablePanel")
		combineutilities:CreateTitle(ix.gui.apartments.shopsFrame, ix.gui.apartments, "sklepy")

		local decrementApartments, incrementApartments = ix.gui.apartments.shopsFrame:Add("DButton"), ix.gui.apartments.shopsFrame:Add("DButton")
		combineutilities:CreateTitleFrameRightTextButton(incrementApartments, ix.gui.apartments.shopsFrame, 87, "nast. strona", RIGHT)
		incrementApartments:SetZPos(2)
		combineutilities:CreateTitleFrameRightTextButton(decrementApartments, ix.gui.apartments.shopsFrame, 87, "poprz. strona", RIGHT)
		decrementApartments:SetZPos(3)
		incrementApartments:DockMargin(SScaleMin(20 / 3), 0, 0 - SScaleMin(3 / 3), SScaleMin(6 / 3))
	
		ix.gui.apartments.nextClick = CurTime()
	
		decrementApartments.DoClick = function()
			if ix.gui.apartments.nextClick > CurTime() then return end
	
			ix.gui.apartments.curCollect = math.max(ix.gui.apartments.curCollect - 5, 5)
			ix.gui.apartments:GetApartments(ix.gui.apartments.curCollect)
	
			ix.gui.apartments.nextClick = CurTime() + 1
		end
	
		incrementApartments.DoClick = function()
			if ix.gui.apartments.nextClick > CurTime() then return end
	
			ix.gui.apartments.curCollect = ix.gui.apartments.curCollect + 5
			ix.gui.apartments:GetApartments(ix.gui.apartments.curCollect)
	
			ix.gui.apartments.nextClick = CurTime() + 1
		end

		ix.gui.apartments.content2 = ix.gui.apartments:Add("DScrollPanel")
		ix.gui.apartments.content2:Dock(FILL)

		ix.gui.apartments:CreateApartments(shops, false, true)
	end)
end)

netstream.Hook("UpdateIndividualApartment", function(appID, tApartment)
	if IsValid(ix.gui.apartments) and ix.gui.apartments.ViewSingleApartment then
		ix.gui.apartments:ViewSingleApartment(appID, tApartment)
	end
end)

local doors = ix.plugin.list["doors"]
if !doors then return end

do
	doors.DrawDoorInfo = function(self, door, width, position, angles, scale, clientPosition)
		local alpha = math.max((1 - clientPosition:DistToSqr(door:GetPos()) / 65536) * 255, 0)

		if (alpha < 1) then
			return
		end

		local info = hook.Run("GetDoorInfo", door) or self:GetDefaultDoorInfo(door)

		if (!istable(info) or table.IsEmpty(info)) then
			return
		end

		-- title + background
		surface.SetFont("WN3D2DLargeText")
		if string.len(info.name) > 23 then
			surface.SetFont("WN3D2DMediumText")
		end
		local nameWidth, nameHeight = surface.GetTextSize(info.name)

		surface.SetTextColor(ColorAlpha(color_white, alpha))
		surface.SetTextPos(-nameWidth * 0.5, -nameHeight * 0.5)
		surface.DrawText(info.name)

		-- description
		local lines = ix.util.WrapText(info.description, width, "ix3D2DSmallFont")
		local y = nameHeight * 0.5 + 4

		for i = 1, #lines do
			local line = lines[i]
			if line:find(L("dIsOwnable")) or line:find(L("dIsNotOwnable")) then return end
			local textWidth, textHeight = surface.GetTextSize(line)

			surface.SetTextPos(-textWidth * 0.5, y)
			surface.DrawText(line)

			y = y + textHeight
		end
	end
end

function PLUGIN:CreateExtraCharacterTabInfo(character, informationSubframe, CreatePart)
	local genericData = character:GetGenericdata()
	local genericHousing = genericData.housing
	if genericHousing then
		netstream.Start("RequestApartmentNames", tonumber(genericData.housing))
	end

	local housing = ix.plugin.list["housing"]
	local apartments = housing.apartments or {}

	-- Apartment
	local apartmentPanel = informationSubframe:Add("Panel")
	CreatePart(apartmentPanel, "Apartment:", (genericHousing and apartments[tonumber(genericData.housing)] and apartments[tonumber(genericData.housing)].name) or "N/A", "cid")
end