--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name = "WN7sfuff"
PLUGIN.description = "Some fun staff!!"
PLUGIN.author = "Legion"

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	function PLUGIN:InitializedPlugins()
		local function drawWorkESP(client, entity, x, y, factor)
			ix.util.DrawText("Broken (Work) "..entity:GetClass(), x, y - math.max(10, 32 * factor), Color(185, 179, 38),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, math.max(255 * factor, 80))
		end

		ix.observer:RegisterESPType("ix_workerk_water", drawWorkESP, "work")
		ix.observer:RegisterESPType("ix_workerk_gas", drawWorkESP, "work")
		ix.observer:RegisterESPType("ix_workerk_electric", drawWorkESP, "work")
	end
else
	-- Called when loading all the data that has been saved.
	function PLUGIN:LoadData()
		if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

		for _, v in ipairs(ix.data.Get("wn_scaffolds") or {}) do
			local entity = ents.Create("wn_scaffold")
			entity:SetPos(v.pos)
			entity:SetAngles(v.angles)
			entity:Spawn()

			entity:SetSolid(SOLID_VPHYSICS)
			entity:PhysicsInit(SOLID_VPHYSICS)

			local physObj = entity:GetPhysicsObject()

			if (IsValid(physObj)) then
				physObj:EnableMotion(false)
				physObj:Sleep()
			end

			entity.items = v.materials or 0
			entity:SetNWInt("ItemsRequired", v.materials or 0)
		end
	end

	-- Called just after data should be saved.
	function PLUGIN:SaveData()
		self:SaveScaffolds()
	end

	-- This is a seperate function so we can call it upon deploying a radio.
	function PLUGIN:SaveScaffolds()
		local scaffolds = {}

		-- This is faster than two single ents.FindByClass
		local entities = ents.GetAll()
		for i = 1, #entities do
			local entityClass = entities[i]:GetClass()
			if (entityClass == "wn_scaffold") then
				scaffolds[#scaffolds + 1] = {
					pos = entities[i]:GetPos(),
					angles = entities[i]:GetAngles(),
					materials = entities[i].items
				};
			end
		end;

		ix.data.Set("wn_scaffolds", scaffolds)
	end
end
