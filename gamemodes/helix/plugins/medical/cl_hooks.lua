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

ix.hud.DrawDeath = function() end


do
	local healthIcon = ix.util.GetMaterial("willardnetworks/hud/hp.png")
	local armorIcon = ix.util.GetMaterial("willardnetworks/hud/armor.png")

	function PLUGIN:DrawImportantBars(client, character, alwaysShow, minimalShow, DrawBar)
		local maxHealth = client:GetMaxHealth()
		local fractionHealth, fractionFakeHealth = client:Health() / maxHealth, character:GetHealing("fakeHealth") / maxHealth
		if (alwaysShow or ((fractionHealth < 1 or fractionFakeHealth > 0) and (!minimalShow or (fractionHealth < 0.8 and fractionFakeHealth < 0.2)))) then
			-- Health/Fake Health
			if (fractionFakeHealth == 0) then
				DrawBar(healthIcon, fractionHealth)
			else
				DrawBar(healthIcon, fractionHealth - fractionFakeHealth, fractionHealth)
			end
		end

		-- Armor
		if (alwaysShow or client:Armor() > 0) then
			local isOTA = client:Team() == FACTION_OTA
			if (alwaysShow or !minimalShow or (isOTA and client:Armor() != 150) or (!isOTA and client:Armor() != 50)) then
				local fraction = client:Armor() / (isOTA and 150 or 50)
				DrawBar(armorIcon, fraction, nil, (fraction > 1 and (fraction - 1)) or nil)
			end
		end
	end

	function PLUGIN:DrawAlertBars(client, character, DrawBar)
		if (character:GetBleedout() > 0) then
			DrawBar(L("areBleeding"))
		end
	end

	local bleedoutMaterial = ix.util.GetMaterial("willardnetworks/nlrbleedout/bleedout-background.png")
	function PLUGIN:DrawHUDOverlays(client, character)
		local health = client:Health() * 100 / client:GetMaxHealth()
		if (health <= 90) then
			surface.SetDrawColor(Color(255, 0, 0, math.Remap(math.max(health, 0), 90, 0, 0, 80)))
			surface.SetMaterial(bleedoutMaterial)
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end
	end
end

function PLUGIN:GetPlayerESPText(client, toDraw, distance, alphaFar, alphaMid, alphaClose)
	local character = client:GetCharacter()
	if (character:GetBleedout() > 0) then
		toDraw[#toDraw + 1] = {alpha = alphaFar, priority = 3, text = "Bleedout: "..character:GetBleedout()}
	end

    if (character:GetHealing() and
		(character:GetHealing("painkillers") > 0 or character:GetHealing("fakeHealth") > 0 or
		character:GetHealing("bandage") > 0 or character:GetHealing("disinfectant") > 0)) then
		local text1 = string.format("Healing: B:%d/D:%ds",
			character:GetHealing("bandage"),
			character:GetHealing("disinfectant")
		)

		toDraw[#toDraw + 1] = {alpha = alphaClose, priority = 22.001, text = text1}
		if (character:GetHealing("painkillers") > 0 or character:GetHealing("fakeHealth") > 0) then
			local text2 = string.format("    P:%d - %ds/F: %d",
				character:GetHealing("painkillers"),
				character:GetHealing("painkillersDuration"),
				character:GetHealing("fakeHealth")
			)
			toDraw[#toDraw + 1] = {alpha = alphaClose, priority = 22.002, text = text2}
		end
	end
end

function PLUGIN:GetInjuredText(client)
	if (!client:Alive()) then
		return "injDead", self:GetColor(0)
	end

	local character = client:GetCharacter()
	local health = client:Health()
	local maxHealth = client:GetMaxHealth()

	local bandage = character:GetHealing("bandage")
	local disinfectant = character:GetHealing("disinfectant")
	local fakeHealth = character:GetHealing("fakeHealth")

	-- totalHealthFraction
	local thf = math.Clamp((health - fakeHealth) / maxHealth, 0, 1)

	if (character:GetBleedout() > 0) then
		return "bleedingOut", self:GetColor(thf - 0.1)
	end

	if (bandage > 0) then
		if ((!ix.action or character:CanDoAction("check_sufficient_bandage")) and bandage + (health - fakeHealth) >= maxHealth) then
			if (disinfectant > 0) then
				return "allBandagedDis", self:GetColor(thf + 0.3)
			else
				return "allBandaged", self:GetColor(thf + 0.2)
			end
		else
			if (disinfectant > 0) then
				return "someBandagedDis", self:GetColor(thf + 0.1)
			else
				return "someBandaged", self:GetColor(thf)
			end
		end
	end

	if (thf < 0) then
		return "injWonder", self:GetColor(thf)
	elseif (thf < 0.2) then
		return "injNearDeath", self:GetColor(thf)
	elseif (thf < 0.4) then
		return "injCrit", self:GetColor(thf)
	elseif (thf < 0.6) then
		return "injMaj", self:GetColor(thf)
	elseif (thf < 0.8) then
		return "injLittle", self:GetColor(thf)
	end
end

function PLUGIN:GetColor(totalHealthFraction)
	return Color(
		math.Clamp(255 * 2 * (1 - totalHealthFraction), 0, 255),
		math.Clamp(255 * 2 * totalHealthFraction, 0, 255),
		0
	)
end

local function textStandard(parent, color, font, topMargin, text)
	parent:Dock(TOP)
	parent:DockMargin(0, SScaleMin(topMargin / 3), 0, 0)
	parent:SetText(text)
	parent:SetTextColor(color)
	parent:SetFont(font)
	parent:SetContentAlignment(5)
	parent:SizeToContents()
end

function PLUGIN:HUDPaintBackground()
	local client = LocalPlayer()
	local character = client:GetCharacter()
	if (!character) then return end

	if ix.bleedout and ix.bleedout:IsVisible() then return end

	if (client:GetLocalVar("blur", 0) > 0 and !client:ShouldDrawLocalPlayer()) and
		character.wasBleeding then
		if ix.gui.bleedoutTextBackground then
			return
		end

		ix.gui.bleedoutTextBackground = vgui.Create("Panel")
		ix.gui.bleedoutTextBackground:SetSize(ScrW(), ScrH())
		ix.gui.bleedoutTextBackground.Paint = function(_, w, h)
			surface.SetDrawColor(ColorAlpha(color_black, 200))
			surface.DrawRect(0, 0, w, h)
		end

		local bleedoutTextPanel = ix.gui.bleedoutTextBackground:Add("Panel")

		local hpInfoText = bleedoutTextPanel:Add("DLabel")
		local requiredHealth = math.ceil(client:GetMaxHealth() * ix.config.Get("WakeupTreshold") / 100)
		textStandard(hpInfoText, Color(200, 200, 200, 255), "TitlesFontNoBoldNoClamp", 0, L("requiredHealth", requiredHealth))

		local currentHPText = bleedoutTextPanel:Add("DLabel")
		textStandard(currentHPText, Color(255, 78, 79, 255), "TitlesFontNoBoldNoClamp", 10, L("currentHP", client:Health()))

		timer.Create("CurrentHPTextUpdate", 1, 0, function()
			if IsValid(currentHPText) then
				currentHPText:SetText("Current HP: "..client:Health())
				currentHPText:SizeToContents()
			else
				timer.Remove("CurrentHPTextUpdate")
			end
		end)

		bleedoutTextPanel:SetSize(SScaleMin(520 / 3), hpInfoText:GetTall() + currentHPText:GetTall() + SScaleMin(10 / 3))
		bleedoutTextPanel:Center()

		local x, y = bleedoutTextPanel:GetPos()
		bleedoutTextPanel:SetPos(x, y - SScaleMin(65 / 3)) -- center but with less y position because Atle
	else
		if ix.gui.bleedoutTextBackground then
			ix.gui.bleedoutTextBackground:Remove()
			ix.gui.bleedoutTextBackground = nil
		end

		if timer.Exists("CurrentHPTextUpdate_"..LocalPlayer():SteamID64()) then
			timer.Remove("CurrentHPTextUpdate_"..LocalPlayer():SteamID64())
		end
	end
end

netstream.Hook("BleedoutScreen", function(bWasBleeding)
    LocalPlayer():GetCharacter().wasBleeding = bWasBleeding
end)

netstream.Hook("ixDeathScreen", function()
	if (IsValid(ix.bleedout)) then
		ix.bleedout:Remove()
	end

	if (IsValid(ix.death)) then
		ix.death:Remove()
	end

	ix.death = vgui.Create("ixDeathScreen")
end)

netstream.Hook("ixBleedoutScreen", function(time)
	if (IsValid(ix.bleedout)) then
		ix.bleedout:Remove()
	end

	if (IsValid(ix.death)) then
		ix.death:Remove()
	end

	ix.bleedout = vgui.Create("ixBleedoutScreen")
	ix.bleedout:SetTime(time)
end)

PLUGIN.netVars = {"table", "bandage", "disinfectant", "painkillers"}
net.Receive("ixHealingData", function(len)
	local id = net.ReadUInt(32)
	local character = ix.char.loaded[id]
	local data = len > 32 and {} or nil

	if (len > 32) then
		local healType = PLUGIN.netVars[net.ReadUInt(2) + 1]
		if (healType == "table") then
			data.bandage = net.ReadUInt(16)
			data.disinfectant = net.ReadUInt(16)
			data.painkillers = net.ReadUInt(16)
			data.painkillersDuration = net.ReadUInt(16)
			data.healingAmount = net.ReadFloat()
			data.fakeHealth = net.ReadFloat()
		else
			data[healType] = net.ReadUInt(16)
			if (healType == "painkillers") then
				data.painkillersDuration = ix.config.Get("HealingPainkillerDuration") * 60
			end
		end
	else
		if (character) then
			character.vars.healing = nil
		end
		return
	end

	if (character) then
		if (!character.vars.healing) then
			character.vars.healing = data
		else
			for k, v in pairs(data) do
				character.vars.healing[k] = v
			end
		end
	end
end)
