--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


net.Receive("ixGestureAnimation", function()
	local client = net.ReadEntity()
	if (!IsValid(client)) then return end

	local sequence = net.ReadString()

	client:AddVCDSequenceToGestureSlot(GESTURE_SLOT_VCD, sequence, 0, true)
end)

net.Receive("ixOpenHandSignalMenu", function()
	if IsValid(ix.gui.handsignalMenu) then ix.gui.handsignalMenu:Remove() end
	vgui.Create("ixGestureWheel")
end)
