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

PLUGIN.name = "Char Creation Necessities"
PLUGIN.author = "Fruity"
PLUGIN.description = "Required stuff for the char creation such as gender etc."
PLUGIN.TIMER_DELAY = PLUGIN.TIMER_DELAY or 60

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("matproxies/sv_matproxies.lua")
ix.util.Include("matproxies/sh_matproxies.lua")
ix.util.Include("matproxies/cl_matproxies.lua")

ix.lang.AddTable("english", {
	optUseImmersiveGlasses = "Utilisez des lunettes",
	optdUseImmersiveGlasses = "Utilisez des lunettes, brouillant la vue de votre personnage s'il a besoin de lunettes et n'en porte pas."
})

ix.lang.AddTable("french", {
	optUseImmersiveGlasses = "Utilisez des lunettes",
	optdUseImmersiveGlasses = "Utilisez des lunettes, brouillant la vue de votre personnage s'il a besoin de lunettes et n'en porte pas."
})

ix.lang.AddTable("spanish", {
	optdUseImmersiveGlasses = "Utiliza las gafas de inmersión, difuminando la vista de tu personaje si necesita gafas y no las lleva puestas.",
	optUseImmersiveGlasses = "Utilizar gafas inmersivas"
})

ix.char.RegisterVar("glasses", {
	field = "glasses",
	fieldType = ix.type.bool,
	default = false,
	isLocal = true,
	bNoDisplay = true
})

ix.char.RegisterVar("canread", {
	field = "canread",
	fieldType = ix.type.bool,
	default = true,
	isLocal = true,
	bNoDisplay = true
})

ix.char.RegisterVar("beardProgress", {
	field = "beard",
	fieldType = ix.type.number,
	default = 0,
	bNoNetworking = true,
	bNoDisplay = true
})

ix.allowedHairColors = {
	gris = {
		Color(244,233,230),
		Color(221,202,195),
		Color(182,170,165),
		Color(151,132,126),
		Color(111,101,98),
		Color(126,122,121),
		Color(89,89,89)
	},
	marrons = {
		Color(95,52,39),
		Color(101,66,56),
		Color(62,50,47),
		Color(80,69,66),
		Color(138,106,96),
		Color(164,149,137),
		Color(85,72,56),
		Color(83,61,50)
	},
	blonds = {
		Color(223,186,155),
		Color(172,129,94),
		Color(145,124,109),
		Color(229,200,170),
		Color(203,191,177),
		Color(184,151,120),
		Color(230,206,168),
		Color(255,216,149)
	},
	["teinte de bleu"] = {
		Color(161,165,167),
		Color(125,132,135)
	}
}

ix.char.RegisterVar("hair", {
	field = "hair",
	fieldType = ix.type.table,
	default = {},
	isLocal = true,
	bNoDisplay = true,
	OnValidate = function(self, data, payload, client)
		if !payload.hair or payload.hair and !istable(payload.hair) then
			return false, "Vous n'avez pas sélectionné les cheveux/la couleur des cheveux !"
		end

		if !istable(payload.hair) then
			return false, "Quelque chose s'est mal passé avec la sélection de cheveux!"
		end

		if !payload.hair.hair then
			return false, "Vous n'avez pas sélectionné les cheveux!"
		end

		if !payload.hair.color then
			return false, "Vous n'avez pas sélectionné la couleur des cheveux!"
		end

		local found = false
		for _, v in pairs(ix.allowedHairColors) do
			if !table.HasValue(v, payload.hair.color) then continue end

			found = true
			break
		end

		if !found then
			return false, "Vous n'avez pas sélectionné de couleur de cheveux autorisée !"
		end

		if !isnumber(payload.hair.hair) then
			return false, "Vous n'avez pas sélectionné de poil autorisé !"
		end

		return true
	end,
	OnGet = function(self, default)
		local hair = self.vars.hair

		return hair or {}
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.hair = value
	end
})

ix.config.Add("forceImmeseriveGlasses", true, "Forcer l'effet des lunettes, même si le client désactive l'option pour eux.", nil, {
	category = "Personnages"
})

do
	local CHAR = ix.meta.character
	function CHAR:HasGlasses()
		for _, v in pairs(self:GetInventory():GetItems()) do
			if (v.glasses and v:GetData("equip")) then
				return true
			end
		end

		return false
	end
end

ix.char.vars["model"].OnDisplay = function(self, container, payload) end
ix.char.vars["model"].OnValidate = function(self, value, payload, client)
	local faction = ix.faction.indices[payload.faction]

	if (faction) then
		local gender = payload.gender
		local models
		if gender == "male" and faction:GetModelsMale(client) then
			models = faction:GetModelsMale(client)
		elseif gender == "female" and faction:GetModelsFemale(client) then
			models = faction:GetModelsFemale(client)
		else
			models = faction:GetModels(client)
		end

		if (!payload.model or !models[payload.model]) then
			return false, "Vous n'avez pas sélectionné de modèle !"
		end
	else
		return false, "Vous n'avez pas sélectionné de modèle!"
	end
end

ix.char.vars["model"].OnAdjust = function(self, client, data, value, newData)
	local faction = ix.faction.indices[data.faction]

	if (faction) then
		local gender = data.gender
		local model
		if gender == "male" and faction:GetModelsMale(client) then
			model = faction:GetModelsMale(client)[value]
		elseif gender == "female" and faction:GetModelsFemale(client) then
			model = faction:GetModelsFemale(client)[value]
		else
			model = faction:GetModels(client)[value]
		end

		if (isstring(model)) then
			newData.model = model
		elseif (istable(model)) then
			newData.model = model[1]
		end
	end
end

ix.char.vars["model"].ShouldDisplay = function(self, container, payload)
	local faction = ix.faction.indices[payload.faction]

	if faction then
		local gender = payload.gender
		if gender == "male" and faction:GetModelsMale(LocalPlayer()) then
			return #faction:GetModelsMale(LocalPlayer()) > 1
		elseif gender == "female" and faction:GetModelsFemale(LocalPlayer()) then
			return #faction:GetModelsFemale(LocalPlayer()) > 1
		else
			return #faction:GetModels(LocalPlayer()) > 1
		end
	end
end

-- Registers the var "Gender"
ix.char.RegisterVar("gender", {
	field = "gender",
	fieldType = ix.type.string,
	default = "male",
	bNoDisplay = true,
	OnSet = function(self, value)
		local client = self:GetPlayer()

		if (IsValid(client)) then
			self.vars.gender = value

			-- @todo refactor networking of character vars so this doesn't need to be repeated on every OnSet override
			net.Start("ixCharacterVarChanged")
				net.WriteUInt(self:GetID(), 32)
				net.WriteString("gender")
				net.WriteType(self.vars.gender)
			net.Broadcast()
		end
	end,
	OnGet = function(self, default)
		local gender = self.vars.gender

		return gender or 0
	end,
	OnValidate = function(self, data, payload, client)
		local faction = ix.faction.indices[payload.faction]
		if (payload.gender == "female" or payload.gender == "male") then
			return true
		end

		if faction then
			if faction:GetNoGender(client) == true then
				return true
			end
		end

		return false, "Vous n'avez pas sélectionné de sexe !"
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.gender = value
	end
})

ix.char.vars["data"].OnValidate = function(self, datas, payload, client)
	local faction = ix.faction.indices[payload.faction]

	if faction then
		if (!payload.data["background"] or payload.data["background"] == "") and faction:GetNoBackground(client) != true then
			return false, "Vous n'avez pas sélectionné votre background !"
		end

		if faction:GetNoGenetics(client) then
			return true
		end

		if !payload.data.age or payload.data["age"] == "" then
			return false, "Vous n'avez pas sélectionné votre âge !"
		end

		if !payload.data.height or payload.data["height"] == "" then
			return false, "Vous n'avez pas sélectionné votre taille !"
		end

		if faction.name != "Vortigaunt" then
			if !payload.data["couleur des yeux"] or payload.data["couleur des yeux"] == "" then
				return false, "Vous n'avez pas sélectionné la couleur de vos yeux !"
			end
		end

		if payload.data.skin < 0 then
			return false, "Vous n'avez pas sélectionné de skin valide !"
		end

		if payload.data.groups then
			if payload.data.groups["2"]then
				if payload.data.groups["2"] < 0 then
					return false, "Vous n'avez pas sélectionné de torse valide !"
				end
			end

			if payload.data.groups["3"] then
				if payload.data.groups["3"] < 0 then
					return false, "Vous n'avez pas sélectionné de pantalon valide !"
				end
			end
		end

		if faction:GetNoAppearances(client) then
			return true
		end

		if faction:GetReadOptionDisabled(client) then
			return true
		end
	end

	return true
end

ix.char.vars["data"].OnAdjust = function(self, client, datas, value, newData)
	newData.data = value
end