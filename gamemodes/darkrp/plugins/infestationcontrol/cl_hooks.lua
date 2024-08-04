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

function PLUGIN:ShouldDrawCrosshair()
	if (LocalPlayer():GetNetVar("InfestationEditMode")) then
		return true
	end
end

local gradient = ix.util.GetMaterial("gui/center_gradient")
local entityMat = CreateMaterial("GA0249aSFJ3","VertexLitGeneric",{
    ["$basetexture"] = "models/debug/debugwhite",
    ["$model"] = 1,
    ["$translucent"] = 1,
    ["$alpha"] = 1,
    ["$nocull"] = 1,
    ["$ignorez"] = 1
})

function PLUGIN:HUDPaint()
	local client = LocalPlayer()
	local infestationMode = client:GetNetVar("InfestationEditMode")

	if (!infestationMode) then return end

	local width = ScrW()

	surface.SetDrawColor(25, 25, 25, 255)
	surface.SetMaterial(gradient)

	if (infestationMode == 0) then
		surface.DrawTexturedRect(0, 30, width, 170)
		
		draw.SimpleText(L("menuMainTitle"), "ixMediumFont", width * 0.5, 50, ix.config.Get("color"), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuMainEdit"), "ixMonoMediumFont", width * 0.5, 90, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuMainCreate"), "ixMonoMediumFont", width * 0.5, 120, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuMainExit"), "ixMonoMediumFont", width * 0.5, 150, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
	
		cam.Start3D()
			for _, entity in pairs(ents.FindByClass("ix_infestation_prop")) do
				local clientPos = client:EyePos()
				local targetPos = entity:GetPos()
				local distance = clientPos:Distance(targetPos)
				
				if (!entity:GetInfestation()) then continue end -- I'm sorry for the mess, but I'm not taking any chances.
				if (!ix.infestation.stored[entity:GetInfestation()]) then continue end
				if (!ix.infestation.stored[entity:GetInfestation()].type) then continue end
				if (!ix.infestation.types[ix.infestation.stored[entity:GetInfestation()].type]) then continue end
				if (!ix.infestation.types[ix.infestation.stored[entity:GetInfestation()].type].color) then continue end

				local color = ix.infestation.types[ix.infestation.stored[entity:GetInfestation()].type].color
				
				render.SuppressEngineLighting(true)

				if (entity:GetCore()) then
					render.SetColorModulation(255 / 255, 0 / 255, 0 / 255)
				else
					render.SetColorModulation(color.r / 255, color.g / 255, color.b / 255)
				end

				if (ix.option.Get("cheapBlur", false)) then
					render.SetBlend(1)
				else
					render.SetBlend(math.Remap(math.Clamp(distance, 200, 4000), 200, 8000, 0.05, 1))
				end

				render.MaterialOverride(entityMat)
				entity:DrawModel()

				render.MaterialOverride()

				render.SuppressEngineLighting(false)
			end
		cam.End3D()
	elseif (infestationMode == 1) then
		surface.DrawTexturedRect(0, 30, width, 200)
		
		draw.SimpleText(L("menuCreateTitle"), "ixMediumFont", width * 0.5, 50, ix.config.Get("color"), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuCreateNotice"), "ixMonoMediumFont", width * 0.5, 90, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuCreateSave"), "ixMonoMediumFont", width * 0.5, 120, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuCreateCore"), "ixMonoMediumFont", width * 0.5, 150, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuCreateExit"), "ixMonoMediumFont", width * 0.5, 180, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
	
		cam.Start3D()
			for _, entity in pairs(ents.FindByClass("prop_physics")) do
				if (!entity:GetNetVar("infestationProp") or entity:GetNetVar("infestationProp") != client:SteamID()) then continue end

				local clientPos = client:EyePos()
				local targetPos = entity:GetPos()
				local distance = clientPos:Distance(targetPos)
				
				render.SuppressEngineLighting(true)

				if (entity:GetNetVar("infestationCore")) then
					render.SetColorModulation(255 / 255, 0 / 255, 0 / 255)
				else
					render.SetColorModulation(255 / 255, 175 / 255, 0 / 255)
				end

				if (ix.option.Get("cheapBlur", false)) then
					render.SetBlend(1)
				else
					render.SetBlend(math.Remap(math.Clamp(distance, 200, 4000), 200, 8000, 0.05, 1))
				end

				render.MaterialOverride(entityMat)
				entity:DrawModel()

				render.MaterialOverride()

				render.SuppressEngineLighting(false)
			end
		cam.End3D()
	elseif (infestationMode == 2) then
		surface.DrawTexturedRect(0, 30, width, 140)
		
		draw.SimpleText(L("menuEditTitle"), "ixMediumFont", width * 0.5, 50, ix.config.Get("color"), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuEditRemove"), "ixMonoMediumFont", width * 0.5, 90, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText(L("menuEditExit"), "ixMonoMediumFont", width * 0.5, 120, Color(255, 175, 0, 255), TEXT_ALIGN_CENTER)
	
		cam.Start3D()
			for _, entity in pairs(ents.FindByClass("ix_infestation_prop")) do
				if (entity:GetInfestation() != client:GetNetVar("InfestationEditName")) then continue end

				local clientPos = client:EyePos()
				local targetPos = entity:GetPos()
				local distance = clientPos:Distance(targetPos)
				
				render.SuppressEngineLighting(true)

				if (entity:GetCore()) then
					render.SetColorModulation(255 / 255, 0 / 255, 0 / 255)
				else
					render.SetColorModulation(255 / 255, 175 / 255, 0 / 255)
				end

				if (ix.option.Get("cheapBlur", false)) then
					render.SetBlend(1)
				else
					render.SetBlend(math.Remap(math.Clamp(distance, 200, 4000), 200, 8000, 0.05, 1))
				end

				render.MaterialOverride(entityMat)
				entity:DrawModel()

				render.MaterialOverride()

				render.SuppressEngineLighting(false)
			end

			for name, data in pairs(ix.infestation.stored) do
				if (name == client:GetNetVar("InfestationEditName")) then
					for index, entityData in ipairs(data.entities) do
						if (index > data.spreadProgress) then
							local clientPos = client:EyePos()
							local targetPos = entityData.position
							local distance = clientPos:Distance(targetPos)

							render.SuppressEngineLighting(true)

							render.SetColorModulation(255 / 255, 255 / 255, 255 / 255)

							if (ix.option.Get("cheapBlur", false)) then
								render.SetBlend(1)
							else
								render.SetBlend(math.Remap(math.Clamp(distance, 200, 4000), 200, 8000, 0.05, 1))
							end

							render.MaterialOverride(entityMat)
							render.Model({model = entityData.model, pos = entityData.position, angle = entityData.angles})

							render.MaterialOverride()

							render.SuppressEngineLighting(false)
						end
					end
				end
			end
		cam.End3D()
	end
end
