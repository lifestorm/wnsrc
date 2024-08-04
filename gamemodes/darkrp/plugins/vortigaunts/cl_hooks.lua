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

local function firstUpper(str)
	return (str:gsub("^%l", string.utf8upper))
end

net.Receive("ixVortNotes", function(len)
	local count = net.ReadUInt(32)
	local send = net.ReadUInt(32)
	local received = send

	if (received == 1) then
		PLUGIN.vortnotes = {}
	end

	for i = send, math.min(count, send + PLUGIN.BATCH - 1) do
		local k = net.ReadUInt(32)
		PLUGIN.vortnotes[k] = net.ReadTable()
		if (received == count) then
			PLUGIN:OpenVortMenu(net.ReadUInt(32))
			return
		end
		received = received + 1
	end
end)

netstream.Hook("OpenVortessenceMenu", function(notes, lastSelected)

end)

local vortalVisionActive = false
local vortalVisionMat = Material("effects/vortal_vision.png")
local vortalVisionDLight = nil

netstream.Hook("ToggleVortalVision", function(bool)
    if (bool and !vortalVisionActive) then
		if !vortalVisionDLight then
			vortalVisionDLight = DynamicLight(LocalPlayer():EntIndex())
		end

        hook.Add("RenderScreenspaceEffects", "VortalVisionRender", function()
            if vortalVisionDLight then
                vortalVisionDLight.pos = LocalPlayer():GetShootPos() + LocalPlayer():EyeAngles():Forward() * -100
                vortalVisionDLight.r = 255
                vortalVisionDLight.g = 255
                vortalVisionDLight.b = 255
                vortalVisionDLight.brightness = 1
                vortalVisionDLight.Decay = 20000
                vortalVisionDLight.Size = 8000
                vortalVisionDLight.DieTime = CurTime() + 0.1
            end

            DrawColorModify({
                ["$pp_colour_addr"] = 0,
                ["$pp_colour_addg"] = 0,
                ["$pp_colour_addb"] = 0,
                ["$pp_colour_brightness"] = -0.1,
                ["$pp_colour_contrast"] = 1,
                ["$pp_colour_colour"] = 0,
                ["$pp_colour_mulr"] = 0,
                ["$pp_colour_mulg"] = 0,
                ["$pp_colour_mulb"] = 0
            })

            surface.SetDrawColor(255, 255, 255, 100)
            surface.SetMaterial(vortalVisionMat)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end)

        vortalVisionActive = true
	else
		hook.Remove("RenderScreenspaceEffects", "VortalVisionRender")

        vortalVisionActive = false
    end
end)

function PLUGIN:OpenVortMenu(lastSelected)
	if IsValid(PLUGIN.ixVortessenceMenu) then
		PLUGIN.ixVortessenceMenu:Remove()
	end

	PLUGIN.ixVortessenceMenu = vgui.Create("VortessenceMenu")

	if lastSelected > 0 and PLUGIN.ixVortessenceMenu.buttonList and PLUGIN.ixVortessenceMenu.buttonList[lastSelected] then
		PLUGIN.ixVortessenceMenu.buttonList[lastSelected].DoClick()
	end
end

function PLUGIN:IsPlayerRecognized(target)
	if LocalPlayer():IsVortigaunt() then
		local vortrecognition = ix.data.Get("vortrecog", {}, false, true)

		if (target:GetCharacter() and vortrecognition[target:GetCharacter():GetID()]) then
			return true
		end
	end
end

function PLUGIN:GetCharacterName(target, chatType)
	if LocalPlayer():IsVortigaunt() then
		local vortrecognition = ix.data.Get("vortrecog", {}, false, true)

		if target:GetCharacter() then
			local fakeName = vortrecognition[target:GetCharacter():GetID()]

			if (fakeName and fakeName != true) then
				return fakeName
			end
		end
	end
end

PLUGIN.minDist = 500 * 500
PLUGIN.maxDist = 20000 ^ 2
PLUGIN.traceFilter = {nil, nil}
local mat1 = CreateMaterial("GA0249aSFJ3","VertexLitGeneric",{
	["$basetexture"] = "models/debug/debugwhite",
	["$model"] = 1,
	["$translucent"] = 1,
	["$alpha"] = 1,
	["$nocull"] = 1,
	["$ignorez"] = 1
})

function PLUGIN:HUDPaint()
	local client = LocalPlayer()
	local isVortigaunt = client:IsVortigaunt()

	if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle() and !isVortigaunt) then return end
	if (!client:GetCharacter()) then return end

	if (client:GetNetVar("ixVortNulled")) then return end

	if client:GetNetVar("ixVortMeditation") then
		surface.SetDrawColor( Color(38, 106, 46, (math.sin(CurTime() * 2) + 1) / 2 * 80) )
		surface.SetMaterial(ix.util.GetMaterial("vgui/gradient-d"))
    	surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
	end

	if (ix.option.Get("vortSensingDisable")) then return end

	if (isVortigaunt) then
		self.names = {}

		local minDist, maxDist = self.minDist, self.maxDist
		if (ix.char.loaded[self.voidChar] and IsValid(ix.char.loaded[self.voidChar]:GetPlayer())) then
			local voidClient = ix.char.loaded[self.voidChar]:GetPlayer()
			if (voidClient:GetMoveType() != MOVETYPE_NOCLIP or voidClient:InVehicle()) then
				local pos = voidClient:GetPos()
				local dist = pos:DistToSqr(voidClient:GetPos())

				local offset = math.min(math.Remap(math.max(dist, 50 * 50), 50 * 50, 300 * 300, 0, 1), 1)
				minDist, maxDist = minDist * offset, maxDist * offset
			end
		end

		cam.Start3D()
			local pos = client:EyePos()
			self.traceFilter[1] = client

			for _ , p in ipairs(player.GetAll()) do
				if (p == client) then continue end
				if (!p:GetCharacter()) then continue end
				if (!IsValid(p) or !p:Alive() or (p:GetMoveType() == MOVETYPE_NOCLIP and !p:InVehicle())) then continue end

				local vEyePos = p:EyePos()
				local dist = vEyePos:DistToSqr(pos)

				local voidChar = p:GetCharacter():GetID() == self.voidChar
				local isVort = p:IsVortigaunt() and !p:GetNetVar("ixVortNulled")
				if (voidChar or (dist < maxDist and isVort)) then
					render.SuppressEngineLighting(true)
						if (p:IsVortigaunt()) then
							render.SetColorModulation(138/255, 181/255, 40/255)
						else
							render.SetColorModulation(0, 0, 0)
						end

						if (isVort) then
							self.traceFilter[2] = p
							local trace = util.QuickTrace(pos, vEyePos - pos, self.traceFilter)
							if (util.QuickTrace(pos, vEyePos - pos, self.traceFilter).Fraction < 0.95 or client:FlashlightIsOn()) then
								render.SetBlend(math.Remap(math.Clamp(dist, minDist, maxDist), minDist, maxDist, 1, 0))
							else
								render.SetBlend(math.Remap(math.Clamp(dist, minDist, maxDist), minDist, maxDist, 0.01, 0))
							end
						elseif (voidChar) then
							render.SetBlend(math.Remap(math.max(dist, 100 * 100), 100 * 100, 600 * 600, 0.8, 0))
						end
						render.MaterialOverride(mat1)
						p:DrawModel()

						render.MaterialOverride()
					render.SuppressEngineLighting(false)

					if (!voidChar) then
						self.names[#self.names + 1] = {p, dist}
					end
				end
			end
		cam.End3D()

		self:RenderESPNames(minDist, maxDist)
	end
end

function PLUGIN:CharacerLoaded(character)
	if self.dlight then
		self.dlight = nil
	end
end

function PLUGIN:CharacterAdjustModelPanelLookupBone(character)
	if (character:IsVortigaunt()) then
		return "ValveBiped.head"
	end
end


function PLUGIN:GetCharacterGeneticDescription(character)
	if (character:IsVortigaunt()) then
		local geneticAge = string.utf8lower(LocalPlayer():GetCharacter():GetAge())
		local geneticHeight = string.utf8lower(LocalPlayer():GetCharacter():GetHeight())
		return firstUpper(geneticAge).." | "..firstUpper(geneticHeight), "genetics"
	end
end

function PLUGIN:CreateStoreViewContents(panel, data, entity)
	if (entity and IsValid(entity)) then
		if (entity:IsPlayer() and entity:IsVortigaunt()) then
			panel.storageInventory.isVortigauntOwner = true
		end
	end
end

local path = "willardnetworks/tabmenu/inventory/equipslots/icon-"
local partPaintsVort = {
	[1] = {icon = ix.util.GetMaterial(path.."vorthead.png"), category = "Head"},
	[3] = {icon = ix.util.GetMaterial(path.."collar.png"), category = "Face"},
	[5] = {icon = ix.util.GetMaterial(path.."meat.png"), category = "Hands"},
	[6] = {icon = ix.util.GetMaterial(path.."shackles.png"), category = "Legs"},
	[7] = {icon = ix.util.GetMaterial(path.."hooks.png"), category = "Shoes"}
}
function PLUGIN:GetEquipSlotsPartPaints(panel, openedStorage)
	local isVortigaunt = openedStorage and LocalPlayer():IsVortigaunt() or panel.isVortigauntOwner
	if (isVortigaunt) then
		return partPaintsVort
	end
end

function PLUGIN:CanEquipSlot(panel, openedStorage, slot)
	local isVortigaunt = openedStorage and LocalPlayer():IsVortigaunt() or panel.isVortigauntOwner
	if (isVortigaunt and slot == 10) then
		return false
	end
end

