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

PLUGIN.name = "Usable Entities"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Rend certaines entités réellement utilisables."

PLUGIN.usableEntityLookup = {
	["models/props_c17/clock01.mdl"] = {class = "ix_clock"},
	["models/props_combine/breenclock.mdl"] = {class = "ix_clock"},
	["models/props_trainstation/clock01.mdl"] = {class = "ix_clock"},
	["models/props_trainstation/trainstation_clock001.mdl"] = {class = "ix_clock"},
	["models/props_interiors/furniture_lamp01a.mdl"] = {class = "ix_lamp", upOffset = 50, lightSize = 500, color = Color(255, 216, 135)},
	["models/props_interiors/furniture_lamp01a_static.mdl"] = {class = "ix_lamp", upOffset = 50, lightSize = 500, color = Color(255, 216, 135)},
	["models/props_interiors/lamp_floor.mdl"] = {class = "ix_lamp", upOffset = 60, lightSize = 500, changeSkin = true, color = Color(255, 216, 135)},
	["models/props_interiors/lamp_table02.mdl"] = {class = "ix_lamp", upOffset = 30, lightSize = 500, changeSkin = true, color = Color(255, 216, 135)},
	["models/props_lab/desklamp01.mdl"] = {class = "ix_lamp", forwardOffset = 10, lightSize = 256, color = Color(255, 216, 135)},
	["models/props_combine/combine_light001a.mdl"] = {class = "ix_lamp", forwardOffset = -30, upOffset = 25, lightSize = 500, color = Color(175, 175, 255), sound = "buttons/button1.wav"},
	["models/props_combine/combine_light001b.mdl"] = {class = "ix_lamp", forwardOffset = -50, upOffset = 35, lightSize = 1000, color = Color(175, 175, 255), sound = "buttons/button1.wav"},
	["models/props_combine/combine_light002a.mdl"] = {class = "ix_lamp", forwardOffset = -30, upOffset = 25, lightSize = 500, color = Color(175, 175, 255), sound = "buttons/button1.wav"},
	["models/props_c17/furnituretoilet001a.mdl"] = {class = "ix_toilet"},
	["models/props_wasteland/prison_toilet01.mdl"] = {class = "ix_toilet"},
}

ix.container.Register("models/props/cs_office/bookshelf1.mdl", {
	name = "Bibliothèque",
	description = "Une bibliothèque avec cinq étagères.",
	width = 4,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props/cs_office/bookshelf2.mdl", {
	name = "Bibliothèque",
	description = "Une bibliothèque avec cinq étagères.",
	width = 4,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props/cs_office/bookshelf3.mdl", {
	name = "Bibliothèque",
	description = "Une bibliothèque avec cinq étagères.",
	width = 4,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props_interiors/desk_executive.mdl", {
	name = "Bureau en bois",
	description = "Un grand bureau en bois avec quatre petits tiroirs de chaque côté.",
	width = 2,
	height = 2
})

ix.container.Register("models/props_combine/breendesk.mdl", {
	name = "Bureau en bois",
	description = "Un grand bureau en bois avec quatre petits tiroirs de chaque côté.",
	width = 2,
	height = 2
})

ix.container.Register("models/props_furniture/desk1.mdl", {
	name = "Bureau en bois",
	description = "Un bureau en bois de taille moyenne avec quatre petits tiroirs et deux grands de chaque côté.",
	width = 2,
	height = 2
})

ix.container.Register("models/props_interiors/furniture_desk01a.mdl", {
	name = "Bureau en bois",
	description = "Un bureau en bois de taille moyenne avec quatre petits tiroirs et deux grands de chaque côté.",
	width = 2,
	height = 2
})

ix.container.Register("models/props_interiors/desk_metal.mdl", {
	name = "Bureau en métal",
	description = "Un petit bureau en métal avec un assortiment de tiroirs.",
	width = 2,
	height = 2
})

ix.container.Register("models/props_office/desk_01.mdl", {
	name = "Bureau en métal",
	description = "Un petit bureau en métal avec un assortiment de tiroirs.",
	width = 2,
	height = 2
}) 

ix.container.Register("models/props_street/trashbin01.mdl", {
	name = "Poubelle",
	description = "Une grande poubelle en plastique utilisée pour jeter les déchets.",
	width = 3,
	height = 8
})

ix.container.Register("models/props_trainstation/trashcan_indoor001a.mdl", {
	name = "Poubelle",
	description = "Une grande poubelle en métal utilisée pour jeter les déchets.",
	width = 3,
	height = 3
})

ix.container.Register("models/props/cs_office/trash_can.mdl", {
	name = "Petite poubelle",
	description = "Une petite poubelle en plastique utilisée pour jeter les déchets.",
	width = 2,
	height = 2
})

ix.container.Register("models/props/cs_office/trash_can_p.mdl", {
	name = "Petite poubelle",
	description = "Une petite poubelle en plastique utilisée pour jeter les déchets.",
	width = 2,
	height = 2
})

ix.container.Register("models/props_interiors/paper_tray.mdl", {
	name = "Bac à papier",
	description = "Un bac à papier, utilisé pour stocker des morceaux de papier.",
	width = 1,
	height = 10,
	restriction = {"paper"}
})

ix.container.Register("models/props/cs_office/file_box.mdl", {
	name = "Boîte à dossiers",
	description = "Une boîte à dossiers, utilisée pour stocker du papier, des blocs-notes et des dossiers.",
	width = 9,
	height = 1,
	restriction = {"paper", "notepad"}
})

ix.container.Register("models/props/cs_office/file_box_p1.mdl", {
	name = "Boîte à dossiers",
	description = "Une boîte à dossiers, utilisée pour stocker du papier, des blocs-notes et des dossiers.",
	width = 9,
	height = 1,
	restriction = {"paper", "notepad"}
})

ix.container.Register("models/props/cs_office/file_box_p2.mdl", {
	name = "Boîte à dossiers",
	description = "Une boîte à dossiers, utilisée pour stocker du papier, des blocs-notes et des dossiers.",
	width = 9,
	height = 1,
	restriction = {"paper", "notepad"}
})

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

function PLUGIN:InitializedPlugins()
	ix.inventory.Register("toilet", 1, 1)
end

properties.Add("ixUsableEntityCreate", {
	MenuLabel = "Devenir utilisable",
	Order = 401,
	MenuIcon = "icon16/wand.png",
	Filter = function(self, entity, client)
		if (entity:GetClass() != "prop_physics") then return false end
		if (!gamemode.Call("CanProperty", client, "ixUsableEntityCreate", entity)) then return false end

		local model = string.lower(entity:GetModel())

		if (!PLUGIN.usableEntityLookup[model]) then return false end

		return true
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

		local model = string.lower(entity:GetModel())
		local entityClass = PLUGIN.usableEntityLookup[model].class

		local usableEntity = ents.Create(entityClass)
		usableEntity:SetPos(entity:GetPos())
		usableEntity:SetAngles(entity:GetAngles())
		usableEntity:SetModel(model)
		usableEntity:Spawn()
		
		entity:Remove()

		ix.log.Add(client, "usableEntitySpawned", entityClass, model)
	end
})
