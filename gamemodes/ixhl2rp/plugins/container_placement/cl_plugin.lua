--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local actionsFont = "LargerTitlesFont"
local colorYellow = Color(255, 205, 0)
local colorRedT = Color(255, 0, 0, 230)
local colorGreenT = Color(0, 255, 0, 230)
local arrowBinds = {
	["+left"] = true,
	["+right"] = true,
	["+lookup"] = true,
	["+lookdown"] = true
}

function PLUGIN:PlayerButtonDown(client, button)
	local containerInfo = client:GetLocalVar("containerToPlaceInfo")

	if (containerInfo and IsValid(client.ixContainerCP)) then
		if (button == MOUSE_LEFT) then
			if (!client.ixContainerCP.bInSolidEnviromentOrFloating) then
				net.Start("ixPlaceContainer")
					net.WriteBool(true)
					net.WriteVector(client.ixContainerCP:GetPos())
					net.WriteAngle(client.ixContainerCP:GetAngles())
				net.SendToServer()
			else
				client:EmitSound("buttons/button10.wav")
			end
		elseif (button == MOUSE_RIGHT) then
			net.Start("ixPlaceContainer")
				net.WriteBool(false)
			net.SendToServer()
		end
	end
end

function PLUGIN:PostDrawTranslucentRenderables()
	local client = LocalPlayer()
	local containerInfo = client and client:GetLocalVar("containerToPlaceInfo")

	if (containerInfo) then
		local traceData = {}
			traceData.start = client:GetShootPos()
			traceData.endpos = traceData.start + client:GetAimVector() * 96
			traceData.filter = client
		local traceResult = util.TraceLine(traceData)

		if (!IsValid(client.ixContainerCP)) then
			client.ixContainerCP = ents.CreateClientProp(containerInfo.model)

			client.ixContainerCP:Spawn()
			client.ixContainerCP:Activate()
		end

		local containerMaxs = client.ixContainerCP:OBBMaxs()
		local containerPos = traceResult.HitPos
		containerPos:Add(Vector(0, 0, containerMaxs.z + 1))
		client.ixContainerCP:SetPos(containerPos)

		local yFacePlayer = math.NormalizeAngle(EyeAngles().y + 180)
		local containerAngles = Angle(0, yFacePlayer, 0)

		if (client.ixContainerRotationAngles) then
			containerAngles:Add(client.ixContainerRotationAngles)
		end

		client.ixContainerCP:SetAngles(containerAngles)

		if (client.ixContainerCP:IsInSolidEnviromentOrFloating()) then
			client.ixContainerCP.bInSolidEnviromentOrFloating = true

			client.ixContainerCP:SetColor(colorRedT)
		else
			client.ixContainerCP.bInSolidEnviromentOrFloating = false

			client.ixContainerCP:SetColor(colorGreenT)
		end

		client.ixContainerCP:SetRenderMode(RENDERMODE_TRANSCOLOR)
	end
end

function PLUGIN:Think()
	local client = LocalPlayer()
	local containerInfo = client and client:GetLocalVar("containerToPlaceInfo")

	if (!containerInfo and IsValid(client.ixContainerCP)) then
		client.ixContainerCP:Remove()

		client.ixContainerCP = nil
		client.ixContainerRotationAngles = nil
	elseif (containerInfo) then
		client.ixContainerRotationAngles = client.ixContainerRotationAngles or Angle(0, 0, 0)

		-- reset angles
		if (input.IsKeyDown(KEY_R)) then
			client.ixContainerRotationAngles:Zero()
		end

		-- horizontally
		if (input.IsKeyDown(KEY_LEFT)) then
			client.ixContainerRotationAngles:Add(Angle(0, -1, 0))
		end
		if (input.IsKeyDown(KEY_RIGHT)) then
			client.ixContainerRotationAngles:Add(Angle(0, 1, 0))
		end

		-- vertically
		if (input.IsKeyDown(KEY_UP)) then
			client.ixContainerRotationAngles:Add(Angle(0, 0, 1))
		end
		if (input.IsKeyDown(KEY_DOWN)) then
			client.ixContainerRotationAngles:Add(Angle(0, 0, -1))
		end
	end
end

function PLUGIN:PlayerBindPress(client, bind)
	local containerInfo = client and client:GetLocalVar("containerToPlaceInfo")

	if (containerInfo and IsValid(client.ixContainerCP) and arrowBinds[bind]) then
		return true
	end
end

function PLUGIN:HUDPaint()
	local client = LocalPlayer()
	local containerInfo = client and client:GetLocalVar("containerToPlaceInfo")

	if (containerInfo) then
		local scrW, scrH = ScrW(), ScrH()
		local halfW = scrW * 0.5

		draw.TextShadow({
			text = string.format("CONTAINER \"%s\" PLACEMENT UI", containerInfo.name),
			font = "HUDFontLarge",
			pos = {halfW, scrH * 0.18},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = colorYellow
		}, 1)

		surface.SetFont(actionsFont)
		local actionMaxW, actionH = surface.GetTextSize("L/R ARROWS - ROTATE HORIZONTALLY")
		local actionX = halfW - actionMaxW * 0.5
		local actionsY = scrH * 0.88

		-- I could've used loop here, but that would mean creating 2 of them
		draw.TextShadow({
			text = "LMB - PLACE",
			font = actionsFont,
			pos = {actionX, actionsY},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER
		}, 1)

		draw.TextShadow({
			text = "RMB - CANCEL",
			font = actionsFont,
			pos = {actionX, actionsY + actionH},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER
		}, 1)

		draw.TextShadow({
			text = "R - RESET ANGLES",
			font = actionsFont,
			pos = {actionX, actionsY + actionH * 2},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER
		}, 1)

		draw.TextShadow({
			text = "L/R ARROWS - ROTATE HORIZONTALLY",
			font = actionsFont,
			pos = {actionX, actionsY + actionH * 3},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER
		}, 1)

		draw.TextShadow({
			text = "U/D ARROWS - ROTATE VERTICALLY",
			font = actionsFont,
			pos = {actionX, actionsY + actionH * 4},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER
		}, 1)
	end
end
