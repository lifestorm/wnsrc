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

PLUGIN.vortalVision = PLUGIN.vortalVision or false
PLUGIN.conterminousAgenda = PLUGIN.conterminousAgenda or nil

local function firstUpper(str)
	return str:gsub("^%l", string.utf8upper)
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

netstream.Hook("conterminousSetConfirm", function(characterName, bool)
	Derma_Query(
		"You are about to set " .. characterName .. "'s conterminous state to " .. tostring(bool) .. ". Are you sure?",
		"Confirmation:",
		"Yes",
		function()
			netstream.Start("conterminousSetState", characterName, bool)
		end,
		"No",
		nil
	)
end)

netstream.Hook("conterminousSetAgenda", function(message)
	if (message != "The Vortigaunt is silent.") then
		if (PLUGIN.conterminousAgenda) then
			PLUGIN.conterminousAgenda:Remove()
			PLUGIN.conterminousAgenda = nil
		end

		PLUGIN.conterminousAgenda = vgui.Create("ixconterminousAgenda")
	end

	text = message:gsub("^%l", string.upper)

	local lastChar = message:sub(-1)

	if (!lastChar:match("[%p%s]")) then
		text = text .. "."
	end

	chat.AddText(Color(25, 138, 17), "[ ! ]: " .. text)
end)

netstream.Hook("conterminousRetrieveAgenda", function(message)
	chat.AddText(Color(25, 138, 17), "[ ! ] : " .. message)
end)

netstream.Hook("ToggleVortalVision", function()
    if (!PLUGIN.vortalVision) then
		hook.Add("RenderScreenspaceEffects", "vortalVision", function()
			if (!LocalPlayer():IsVortigaunt()) then
				PLUGIN.vortalVision = false

				hook.Remove("RenderScreenspaceEffects", "vortalVision")
			end

			local dlight = DynamicLight(LocalPlayer():EntIndex())
			if (dlight) then
				dlight.pos = LocalPlayer():GetShootPos() + LocalPlayer():EyeAngles():Forward() * -100
				dlight.r = 255
				dlight.g = 255
				dlight.b = 255
				dlight.brightness = 1
				dlight.Decay = 20000
				dlight.Size = 2000
				dlight.DieTime = CurTime() + 0.1
			end

			local tab = {}

			tab[ "$pp_colour_addr" ] = 0
			tab[ "$pp_colour_addg" ] = 0
			tab[ "$pp_colour_addb" ] = 0
			tab[ "$pp_colour_brightness" ] = 0
			tab[ "$pp_colour_contrast" ] = 1
			tab[ "$pp_colour_colour" ] = 0
			tab[ "$pp_colour_mulr" ] = 0
			tab[ "$pp_colour_mulg" ] = 0
			tab[ "$pp_colour_mulb" ] = 0

			DrawColorModify(tab)
		end)

		hook.Add("PostDraw2DSkyBox", "StormFox2.SkyBoxRender", function()
			if (!LocalPlayer():IsVortigaunt() or !PLUGIN.vortalVision) then return end

			if (!StormFox2 or !StormFox2.Loaded or !StormFox2.Setting.SFEnabled()) then return end
			if (!StormFox2.util or !StormFox2.Sun or !StormFox2.Moon or !StormFox2.Moon.GetAngle) then return end

			local c_pos = StormFox2.util.RenderPos()
			local sky = StormFox2.Setting.GetCache("enable_skybox", true)
			local use_2d = StormFox2.Setting.GetCache("use_2dskybox",false)
			cam.Start3D(Vector(0, 0, 0), EyeAngles(), nil, nil, nil, nil, nil, 1, 32000)  -- 2d maps fix
				render.OverrideDepthEnable(false,false)
				render.SuppressEngineLighting(true)
				render.SetLightingMode(2)
				if (!use_2d or !sky) then
					hook.Run("StormFox2.2DSkybox.StarRender", c_pos)

					-- hook.Run("StormFox2.2DSkybox.BlockStarRender",c_pos)
					hook.Run("StormFox2.2DSkybox.SunRender", c_pos) -- No need to block, shrink the sun.

					hook.Run("StormFox2.2DSkybox.Moon", c_pos)
				end
				hook.Run("StormFox2.2DSkybox.CloudBox", c_pos)
				hook.Run("StormFox2.2DSkybox.CloudLayer", c_pos)
				hook.Run("StormFox2.2DSkybox.FogLayer",	c_pos)
				render.SuppressEngineLighting(false)
				render.SetLightingMode(0)
				render.OverrideDepthEnable( false, false )
			cam.End3D()

			render.SetColorMaterial()
		end)

		PLUGIN.vortalVision = true

		return
	end

	hook.Remove("RenderScreenspaceEffects", "vortalVision")

	PLUGIN.vortalVision = false
end)

function PLUGIN:GetHookCallPriority(hook)
	if (hook == "GetCharacterName" or hook == "PopulateCharacterInfo") then
		return 1500
	end
end

function PLUGIN:GetCharacterName(target, chatType)
	if (!target) then return end

	if (target == LocalPlayer()) then return end

	local character = target:GetCharacter()

	if (target:IsVortigaunt() and character:GetConterminous()) then
		return "Vortigaunt"
	end

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

function PLUGIN:PopulateCharacterInfo(client, character, container)
	timer.Simple(0.01, function()
		local description =  container:GetRow("description")
		local fullDescription = container:GetRow("fullDescription")

		if (IsValid(description) and character:GetConterminous()) then
			description:Remove()
		end

		if (IsValid(fullDescription) and character:GetConterminous()) then
			fullDescription:Remove()
		end
	end)
end

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
