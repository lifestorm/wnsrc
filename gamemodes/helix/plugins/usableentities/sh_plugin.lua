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
PLUGIN.description = "Makes certain entities actually usable."

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

ix.container.Register("models/props/cs_havana/bookcase_large.mdl", {
	name = "Kitaplık",
	description = "Beş rafı olan büyük bir kitaplık.",
	width = 10,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props/cs_havana/bookcase_small.mdl", {
	name = "Kitaplık",
	description = "Beş rafı olan bir kitaplık.",
	width = 5,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props_furniture/bookcase_small.mdl", {
	name = "Kitaplık",
	description = "Beş rafı olan bir kitaplık.",
	width = 5,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props/cs_office/bookshelf1.mdl", {
	name = "Kitaplık",
	description = "Beş rafı olan bir kitaplık.",
	width = 4,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props/cs_office/bookshelf2.mdl", {
	name = "Kitaplık",
	description = "Beş rafı olan bir kitaplık.",
	width = 4,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props/cs_office/bookshelf3.mdl", {
	name = "Kitaplık",
	description = "Beş rafı olan bir kitaplık.",
	width = 4,
	height = 5,
	restriction = {"book"}
})

ix.container.Register("models/props_interiors/desk_executive.mdl", {
	name = "Ahşap Masa",
	description = "Her iki tarafında dört küçük çekmecesi bulunan büyük bir ahşap masa.",
	width = 2,
	height = 4
})

ix.container.Register("models/props_combine/breendesk.mdl", {
	name = "Ahşap Masa",
	description = "Her iki tarafında üç küçük çekmecesi bulunan büyük bir ahşap masa.",
	width = 2,
	height = 3
})

ix.container.Register("models/props_furniture/desk1.mdl", {
	name = "Ahşap Masa",
	description = "Her iki tarafında dört küçük ve iki büyük çekmecesi bulunan orta boyutlu bir ahşap masa.",
	width = 4,
	height = 2
})

ix.container.Register("models/props_interiors/furniture_desk01a.mdl", {
	name = "Ahşap Masa",
	description = "Her iki tarafında dört küçük ve iki büyük çekmecesi bulunan orta boyutlu bir ahşap masa.",
	width = 4,
	height = 2
})

ix.container.Register("models/props_interiors/desk_metal.mdl", {
	name = "Küçük Metal Masa",
	description = "Çeşitli çekmeceleri olan küçük bir metal masa.",
	width = 2,
	height = 3
})

ix.container.Register("models/props_office/desk_01.mdl", {
	name = "Büyük Metal Masa",
	description = "Her iki tarafında iki çekmece bulunan büyük bir metal masa.",
	width = 2,
	height = 2
})

ix.container.Register("models/props_interiors/trashcan01.mdl", {
	name = "Metal Çöp Kutusu",
	description = "Çöp atmak için kullanılan büyük bir metal çöp kutusu.",
	width = 3,
	height = 7
})

ix.container.Register("models/props_street/trashbin01.mdl", {
	name = "Çöp Kutusu",
	description = "Çöp atmak için kullanılan büyük bir plastik çöp kutusu.",
	width = 3,
	height = 8
})

ix.container.Register("models/props_trainstation/trashcan_indoor001a.mdl", {
	name = "Çöp Kutusu",
	description = "Çöp atmak için kullanılan büyük bir metal çöp kutusu.",
	width = 3,
	height = 8
})

ix.container.Register("models/props/cs_office/trash_can.mdl", {
	name = "Küçük Çöp Kutusu",
	description = "Çöp atmak için kullanılan küçük bir plastik çöp kutusu.",
	width = 2,
	height = 2
})

ix.container.Register("models/props/cs_office/trash_can_p.mdl", {
	name = "Küçük Çöp Kutusu",
	description = "Çöp atmak için kullanılan küçük bir plastik çöp kutusu.",
	width = 2,
	height = 2
})

ix.container.Register("models/props_interiors/paper_tray.mdl", {
	name = "Kağıt Tepsisi",
	description = "Kağıt parçalarını saklamak için kullanılan bir kağıt tepsisi.",
	width = 1,
	height = 10,
	restriction = {"paper", "notepad", "pin"}
})

ix.container.Register("models/props/cs_office/file_box.mdl", {
	name = "Dosya Kutusu",
	description = "Kağıt, not defterleri ve dosyaları saklamak için kullanılan bir dosya kutusu.",
	width = 9,
	height = 1,
	restriction = {"paper", "notepad"}
})

ix.container.Register("models/props/cs_office/file_box_p1.mdl", {
	name = "Dosya Kutusu",
	description = "Kağıt, not defterleri ve dosyaları saklamak için kullanılan bir dosya kutusu.",
	width = 9,
	height = 1,
	restriction = {"paper", "notepad"}
})

ix.container.Register("models/props/cs_office/file_box_p2.mdl", {
	name = "Dosya Kutusu",
	description = "Kağıt, not defterleri ve dosyaları saklamak için kullanılan bir dosya kutusu.",
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
	MenuLabel = "Make Usable",
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
