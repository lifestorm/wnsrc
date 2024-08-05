--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


require("niknaks")

local PLUGIN = PLUGIN

PLUGIN.name = "Clientside Props"
PLUGIN.description = "Adds a way to convert server props to clientside props for performance reasons."
PLUGIN.author = "Aspect™"

PLUGIN.clientProps = PLUGIN.clientProps or {}

ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Clientside Props",
	MinAccess = "admin"
})

ix.option.Add("csentRenderSpeed", ix.type.number, 50, {
	category = "performance",
	min = 1,
	max = 500
})

ix.lang.AddTable("english", {
	optCsentRenderSpeed = "Clientside Prop Render Speed",
	optdCsentRenderSpeed = "How many clientside props should be calcualted every frame. Lower values = more FPS, but slower, higher values = less FPS, but faster.",
	cmdRemoveClientProps = "Remove all clientside props in a radius around you."
})

ix.command.Add("RemoveClientProps", {
	description = "@cmdRemoveClientProps",
	adminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, radius)
		if (radius < 0) then
			client:Notify("Radius must be a positive number!")

			return
		end

		local newTable = {}

		for k, propData in ipairs(PLUGIN.clientProps) do
			if (propData.position:Distance(client:GetPos()) <= radius) then continue end
			
			newTable[#newTable + 1] = propData
		end

		PLUGIN.clientProps = newTable

		net.Start("ixClientProps.MassRemoveProps")
			net.WriteVector(client:GetPos())
			net.WriteUInt(radius, 16)
		net.Broadcast()

		client:Notify("Removed all clientside props in a radius of " .. radius .. " units.")
	end
})

local PERSISTENCE = ix.plugin.Get("persistence")

properties.Add("clientprop", {
	MenuLabel = "Convert to Client Prop",
	Order = 400,
	MenuIcon = "icon16/contrast_low.png",

	Filter = function(self, entity, client)
		return entity:GetClass() == "prop_physics" and CAMI.PlayerHasAccess(client, "Helix - Manage Clientside Props")
	end,

	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end
		
		if (!entity:TestPVS(client)) then
			client:Notify("That prop cannot be converted because its origin is outside the world!")

			return
		end

		-- Unpersist it if it's persisted
		if (PERSISTENCE) then
			for k, v in ipairs(PERSISTENCE.stored) do
				if (v == entity) then
					table.remove(PERSISTENCE.stored, k)

					break
				end
			end

			entity:SetNetVar("Persistent", false)
		end

		local propData = {
			position = entity:GetPos(),
			angles = entity:GetAngles(),
			model = entity:GetModel(),
			skin = entity:GetSkin(),
			color = entity:GetColor(),
			material = entity:GetMaterial()
		}

		entity:Remove()

		PLUGIN.clientProps[#PLUGIN.clientProps + 1] = propData

		PLUGIN:NetworkProp(propData)
	end
})
