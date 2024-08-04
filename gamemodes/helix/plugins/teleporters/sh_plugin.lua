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

PLUGIN.name = "Teleporters"
PLUGIN.author = "Mango"
PLUGIN.description = "A map teleportation system."

ix.config.Add("teleporterTransportTime", 1, "The time it takes for someone to transport through a teleporter in seconds.", nil, {
    data = {min = 1, max = 60},
    category = "Teleporters"
})

ix.config.Add("teleporterAllowedDistance", 1, "The distance required from player to teleporter in square units.", nil, {
    data = {min = 1, max = 500},
    category = "Teleporters"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Teleporters",
	MinAccess = "admin"
})

properties.Add("ixTeleporterGetID", {
	MenuLabel = "Copy ID",
	Order = 405,
	MenuIcon = "icon16/application_double.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() == "ix_teleporter" and CAMI.PlayerHasAccess(client, "Helix - Manage Teleporters", nil)) then return true end
	end,

	Action = function(self, entity)
		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local data = ix.teleporters:RetrieveData(entity)

        if (data and istable(data)) then
            SetClipboardText(data["id"])
        end
	end,
})

properties.Add("ixTeleporterGoToMate", {
	MenuLabel = "Goto Mate",
	Order = 406,
	MenuIcon = "icon16/bullet_go.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() == "ix_teleporter" and CAMI.PlayerHasAccess(client, "Helix - Manage Teleporters", nil)) then return true end
	end,

	Action = function(self, target)
		self:MsgStart()
			net.WriteEntity(target)
		self:MsgEnd()
	end,

    Receive = function(self, length, client)
		local target = net.ReadEntity()

		if (!IsValid(target)) then return end
		if (!self:Filter(target, client)) then return end

		if (ix.teleporters:IsMateValid(target.ID)) then
            local mate = ix.teleporters:TeleporterFindByID(target.Mate)

            client:SetPos(mate:GetPos())
        end
	end
})

properties.Add("ixTeleporterSetModel", {
	MenuLabel = "Set Model",
	Order = 407,
	MenuIcon = "icon16/application_form_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() == "ix_teleporter" and CAMI.PlayerHasAccess(client, "Helix - Manage Teleporters", nil)) then return true end
	end,

	Action = function(self, target)
        Derma_StringRequest(
            "",
            "Input the desired model for the teleporter.",
            target.EntModel,
            function(text)
                self:MsgStart()
                    net.WriteEntity(target)
                    net.WriteString(text)
                self:MsgEnd()
            end
        )
	end,

    Receive = function(self, length, client)
		local target = net.ReadEntity()
        local model = net.ReadString()

		if (!IsValid(target)) then return end
		if (!self:Filter(target, client)) then return end

		ix.teleporters:SetEntModel(target, model)
	end
})

properties.Add("ixTeleporterSetWarpSound", {
	MenuLabel = "Set Warp Sound",
	Order = 408,
	MenuIcon = "icon16/bell.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() == "ix_teleporter" and CAMI.PlayerHasAccess(client, "Helix - Manage Teleporters", nil)) then return true end
	end,

	Action = function(self, target)
        Derma_StringRequest(
            "",
            "Input the desired warp sound for the teleporter.",
            target.WarpSound,
            function(text)
                self:MsgStart()
                    net.WriteEntity(target)
                    net.WriteString(text)
                self:MsgEnd()
            end
        )
	end,

    Receive = function(self, length, client)
		local target = net.ReadEntity()
        local text = net.ReadString()

		if (!IsValid(target)) then return end
		if (!self:Filter(target, client)) then return end

		target.WarpSound = text
	end
})

properties.Add("ixTeleporterSetName", {
	MenuLabel = "Set Name",
	Order = 409,
	MenuIcon = "icon16/bullet_wrench.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() == "ix_teleporter" and CAMI.PlayerHasAccess(client, "Helix - Manage Teleporters", nil)) then return true end
	end,

	Action = function(self, target)
        Derma_StringRequest(
            "",
            "Input the desired name for the teleporter.",
            target.UniqueName,
            function(text)
                self:MsgStart()
                    net.WriteEntity(target)
                    net.WriteString(text)
                self:MsgEnd()
            end
        )
	end,

    Receive = function(self, length, client)
		local target = net.ReadEntity()
        local name = net.ReadString()

		if (!IsValid(target)) then return end
		if (!self:Filter(target, client)) then return end

		target.UniqueName = name
	end
})

ix.command.Add("TeleporterSetWarpPos", {
    description = "Sets the position the player will appear at once warping to the selected teleporter.",
    adminOnly = true,
    arguments = {
        ix.type.number
    },
    OnRun = function(self, client, ID)
        if (!ix.teleporters:CheckPermissions(client)) then
            return
        end

        local pos = client:GetPos()

        ix.teleporters:SetWarpPos(ID, pos)
    end
})

ix.command.Add("TeleporterSetWarpAngles", {
    description = "Sets the angles the player will look at once warping to the selected teleporter.",
    adminOnly = true,
    arguments = {
        ix.type.number
    },
    OnRun = function(self, client, ID)
        if (!ix.teleporters:CheckPermissions(client)) then
            return
        end

        local angles = client:EyeAngles()

        ix.teleporters:SetWarpAngles(ID, angles)
    end
})

ix.command.Add("TeleporterGetID", {
    description = "Prints out the ID of the teleporter you are looking at.",
    adminOnly = true,
    OnRun = function(self, client, ID)
        if (!ix.teleporters:CheckPermissions(client)) then
            return
        end

        local tr = client:GetEyeTraceNoCursor().Entity

        ix.teleporters:GetID(client, tr)
    end
})

ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("cl_hooks.lua")

