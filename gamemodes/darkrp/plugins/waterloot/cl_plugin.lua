--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]



netstream.Hook("ixWaterLootDrinkWater", function(itemID, remainingWater)
    local amountDerma = vgui.Create("DFrame")
    amountDerma:SetSize(SScaleMin(300 / 3), SScaleMin(150 / 3))
    amountDerma:Center()
    amountDerma:SetTitle("Choose Amount")
    DFrameFixer(amountDerma)

    local sliderPanel = amountDerma:Add("ixNumSlider")
    sliderPanel:Dock(TOP)
    sliderPanel:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))
    sliderPanel:SetTall(SScaleMin(50 / 3))
    sliderPanel:SetMax(remainingWater)
    sliderPanel:SetMin(1)
    sliderPanel:SetValue(1)
    sliderPanel.label:SetText("1%")
	sliderPanel.slider.OnValueUpdated = function(panel)
		sliderPanel.label:SetText(tostring(panel:GetValue()).."%")
		sliderPanel.label:SizeToContents()

		sliderPanel:OnValueUpdated()
	end

    local confirm = amountDerma:Add("DButton")
    confirm:Dock(FILL)
    confirm:SetFont("MenuFontNoClamp")
    confirm:SetText("CONFIRM")
    confirm:SetContentAlignment(5)
    confirm.DoClick = function()
        amountDerma:Remove()
        netstream.Start("ixWaterLootDrinkWater", itemID, sliderPanel:GetValue())
    end
end)

netstream.Hook("ixWaterLootCreateProgressTextCookingPot", function(entIndex, updateFinished)
    if !entIndex then return false end
    if !Entity(entIndex) or !IsValid(Entity(entIndex)) then return false end
    local entity = Entity(entIndex)

    if updateFinished then
        entity.finished = true
        return
    elseif updateFinished == false then
        entity.finished = false
        return
    end

    entity.deliveryTime = CurTime() + (ix.config.Get("waterFiltrationTimeNeeded", 1) * 60)
    entity.finished = false

    entity.Draw = function()
        entity:DrawModel()
		local delTime = math.max(math.ceil(entity.deliveryTime - CurTime()), 0)
        if delTime <= 0 and entity.finished == false then return end
        if delTime <= 0 and entity.finished == true then delTime = "DONE" end

		local pos, ang = entity:GetPos(), entity:GetAngles()
		ang:RotateAroundAxis(entity:GetUp(), 90)
		ang:RotateAroundAxis(entity:GetRight(), -90)

		pos = pos + entity:GetUp() * 3
		pos = pos + entity:GetForward() * 8

		local func = function()
			ix.util.DrawText(delTime, 0, -10, color_white, 1, 5, "ixBigFont")
		end

		cam.Start3D2D(pos, ang, .15)
			func()
		cam.End3D2D()
    end
end)