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

PLUGIN.cameraWheelOffset = 1
PLUGIN.cameraWheelDelta = PLUGIN.cameraWheelOffset

PLUGIN.cameraInOutOffset = 0
PLUGIN.cameraInOutDelta = PLUGIN.cameraInOutOffset

local function GetHeadBone(client)
	local head

	for i = 1, client:GetBoneCount() do
		if (string.find(client:GetBoneName(i):lower(), "head")) then
			head = i
			break
		end
	end

	return head
end

function PLUGIN:PlayerBindPress(client, bind, bPressed)
	if (!client:GetNetVar("actEnterAngle")) then
		return
	end

	if (bind:find("+jump") and bPressed) then
		ix.command.Send("ExitAct")

		PLUGIN.cameraInOutOffset = ix.option.Get("thirdpersonEnabled") and 1 or 0

		return true
	end
end

function PLUGIN:InputMouseApply(cmd)
	if !LocalPlayer():GetNetVar("actEnterAngle") then
		return
	end

	local mouseWheel = cmd:GetMouseWheel()

	if mouseWheel != 0 then
		self.cameraWheelOffset = math.Clamp(self.cameraWheelOffset + (-mouseWheel * 0.5), 1.0, 1.5)
	end
end

local traceMin = Vector(-4, -4, -4)
local traceMax = Vector(4, 4, 4)

function PLUGIN:CalcView(client, origin)
	if !client:GetNetVar("actEnterAngle") then
		return
	end

	local frameTime = FrameTime()

	self.cameraWheelDelta = math.Approach(self.cameraWheelDelta, self.cameraWheelOffset, frameTime * 6)
	self.cameraInOutDelta = math.Approach(self.cameraInOutDelta, self.cameraInOutOffset, frameTime * 4)

	local view = {}
	view.drawviewer = self.cameraInOutDelta >= 0.225 * (self.cameraWheelOffset * 0.1)

	local head = GetHeadBone(client)
	local headOffset = Vector(0, 0, 64)

	if head then
		headOffset = client:GetBonePosition(head)
	end

	local currentAngle = client.camAng or angle_zero

	local tracePosition = {}
	tracePosition.start = headOffset + client:GetNetVar("actEnterAngle"):Forward() * 10
	tracePosition.endpos = tracePosition.start - currentAngle:Forward() * (70 * self.cameraInOutDelta) * self.cameraWheelDelta
	tracePosition.filter = client
	tracePosition.ignoreworld = false
	tracePosition.mins = traceMin
	tracePosition.maxs = traceMax

	view.origin = util.TraceHull(tracePosition).HitPos
	view.angles = currentAngle + client:GetViewPunchAngles()

	local aimOrigin = view.origin

	local traceAngle = {}
	traceAngle.start = 	aimOrigin
	traceAngle.endpos = aimOrigin + currentAngle:Forward() * 65535
	traceAngle.filter = client
	traceAngle.ignoreworld = (client:GetMoveType() == MOVETYPE_NOCLIP)

	client:SetEyeAngles((util.TraceLine(traceAngle).HitPos - client:GetShootPos()):Angle())

	return view
end

net.Receive("ixActEnter", function()
	if ix.option.Get("thirdpersonEnabled") then
		PLUGIN.cameraInOutOffset = 1
		PLUGIN.cameraInOutDelta = PLUGIN.cameraInOutOffset
	end

	PLUGIN.cameraInOutOffset = 1
end)

net.Receive("ixActLeave", function()
	PLUGIN.cameraWheelOffset = 1
	PLUGIN.cameraWheelDelta = PLUGIN.cameraWheelOffset

	PLUGIN.cameraInOutOffset = 0
	PLUGIN.cameraInOutDelta = PLUGIN.cameraInOutOffset
end)
