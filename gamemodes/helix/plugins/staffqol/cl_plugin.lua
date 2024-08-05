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
PLUGIN.testSoundOrigin = false

net.Receive("ixPlyGetInfo", function()
	local info = net.ReadTable()
	
	local ixPlyGetInfo = vgui.Create("ixPlyGetInfo")
	ixPlyGetInfo:Populate(info)
end)

net.Receive("ixSendFindItemInfo", function()
	local info = net.ReadTable()
	
	local ixFindItemInfo = vgui.Create("ixFindItemInfo")
	ixFindItemInfo:Populate(info)
end)

net.Receive("ixCharBanAreYouSure", function()
	local name = net.ReadString()
	local charID = net.ReadString()
	Derma_Query("Are you sure you want to ban "..name.." '#"..charID.."'", "Ban "..name,
	"Confirm Operation", function()
		net.Start("ixCharBanAreYouSure")
		net.SendToServer()
	end, "Cancel")
end)

ix.option.Add("espShow3DtestSoundOrigin", ix.type.bool, true, {
	category = "observer",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
	end
})

function PLUGIN:HUDPaint()
	self:DrawPoints("testSoundOrigin")
end

function PLUGIN:DrawPoints(type)
	local client = LocalPlayer()

	local drawESP = ix.option.Get("espShow3D"..type, true) and client:GetMoveType() == MOVETYPE_NOCLIP and
	!client:InVehicle() and CAMI.PlayerHasAccess(client, "Helix - Observer", nil)

	if (drawESP) and self[type] and isvector(self[type]) then
		local scrW, scrH = ScrW(), ScrH()
		local marginX, marginY = scrH * .1, scrH * .1

		local screenPosition = self[type]:ToScreen()
		local x, y = math.Clamp(screenPosition.x, marginX, scrW - marginX), math.Clamp(screenPosition.y, marginY, scrH - marginY)

		local alpha = 255
		local size = 10
		local drawColor = color_white

		surface.SetDrawColor(drawColor.r, drawColor.g, drawColor.b, alpha)
		surface.SetFont("ixGenericFont")
		surface.DrawRect(x - size / 2, y - size / 2, size, size)
		ix.util.DrawText("3D Test Sound "..(type:find("Location") and "Heard From" or "Origin"), x, y - (size + 5), ColorAlpha(drawColor, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
	end
end

net.Receive("ixSync3dSoundTestOrigin", function()
	local origin = net.ReadVector()
	if !origin then return end

	PLUGIN.testSoundOrigin = origin
end)

net.Receive("ixPlay3DSound", function()
	local soundPath = net.ReadString()
	local range = net.ReadUInt(8)
	local soundFile = Sound( soundPath )
	local position = net.ReadVector()

	if !soundFile then return end
	if !range then return end

	local vector = (position != Vector( 0, 0, 0 ) and position) or PLUGIN.testSoundOrigin

	if !vector then PLUGIN:NotifyLackOfLocation() return end
	if !isvector(vector) then PLUGIN:NotifyLackOfLocation() return end

	sound.Play( soundFile, vector, range, 100, 1 )
end)

function PLUGIN:NotifyLackOfLocation()
	LocalPlayer():Notify("You did not set a /Play3DSoundTestOrigin location!")
end