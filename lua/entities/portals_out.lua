--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Base = "portals_base"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Portal (Exit)"
ENT.Category = "Portals"

ENT.Spawnable = true
ENT.Editable = true

ENT.BaseColor = Color(100, 200, 0)

local defaultSound = GetConVar("portals_default_sound")

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Group", {
		KeyName = "group",
		Edit = {
			order = 0,
			type = "Generic"
		}
	})

	self:NetworkVar("String", 1, "TeleportSound", {
		KeyName = "sound",
		Edit = {
			title = "Teleport Sound",
			order = 1,
			type = "Generic"
		}
	})

	self:NetworkVar("Vector", 0, "PortalColor", {
		KeyName = "portalcolor",
		Edit = {
			order = 1,
			type = "VectorColor"
		}
	})

	self:SetTeleportSound(defaultSound:GetString())
	self:SetPortalColor(self.BaseColor:ToVector())
end

local allow = GetConVar("portals_allow_custom_colors")

function ENT:GetCustomColor()
	return allow:GetBool() and self:GetPortalColor():ToColor() or self.BaseColor
end
