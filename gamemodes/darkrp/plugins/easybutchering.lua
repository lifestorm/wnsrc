--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name = "Easy Butchering"
PLUGIN.author = "Enistein"
PLUGIN.description = "Allows butchering of ragdolls with USE key."

local BUTCHERABLE_RAGDOLLS = {
	["models/headcrabclassic.mdl"] = "ing_headcrab_meat",
	["models/headcrab.mdl"] = "ing_headcrab_meat",
	["models/antlion.mdl"] = "ing_antlion_meat",
	["models/zombie/classic.mdl"] = "ing_headcrab_meat"
}

local BUTCHERING_TOOLS = {
	"machete",
	"hatchet",
	"kitknife",
	"cleaver"
}

local BUTCHERING_SOUND = "physics/flesh/flesh_squishy_impact_hard1.wav"

function PLUGIN:OnNPCKilled(npc, attacker, inflictor)
	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetModel(npc:GetModel())
	ragdoll:SetPos(npc:GetPos())
	ragdoll:SetAngles(npc:GetAngles())
	ragdoll:Spawn()
	
	npc:Remove()
end

function PLUGIN:PlayerUse(player, entity)
    local character = player:GetCharacter()
    local model = entity:GetModel()

    if entity:GetClass() == "prop_ragdoll" and BUTCHERABLE_RAGDOLLS[model] then
        if not character:IsVortigaunt() then
            local hasTool = false

            for _, tool in ipairs(BUTCHERING_TOOLS) do
                if character:GetInventory():HasItem(tool) then
                    hasTool = true
                    break
                end
            end

            if not hasTool then
                return player:Notify("Bunu yapmak için kesici bir alete ihtiyacın var.")
            end
        end

        local itemToGive = BUTCHERABLE_RAGDOLLS[model]

        if ix.item.list[itemToGive] then
            if character:IsVortigaunt() then
                player:Notify("Pençelerini kullanarak cesedi parçaladın...")
            else
                player:Notify("Alet ile cesedi parçaladın...")
            end

            player:EmitSound(BUTCHERING_SOUND)

            local ragdollPos = entity:GetPos()
            ix.item.Spawn(itemToGive, ragdollPos)
            entity:Remove()
        end

        return false
    end
end


local TEXT_DISPLAY_DISTANCE = 150

hook.Add("HUDPaint", "ButcherableRagdollDisplay", function ()
    local ply = LocalPlayer()
    local tr = ply:GetEyeTrace()
    
    if IsValid(tr.Entity) and tr.Entity:GetClass() == "prop_ragdoll" and BUTCHERABLE_RAGDOLLS[tr.Entity:GetModel()] and tr.HitPos:Distance(ply:GetPos()) < TEXT_DISPLAY_DISTANCE then
        local pos = tr.Entity:LocalToWorld(tr.Entity:OBBCenter()):ToScreen()

		local keyIndicatorText = "E"
		local key_textWidth, key_textHeight = surface.GetTextSize(keyIndicatorText)

		draw.RoundedBox(4, pos.x-5, pos.y+3, 120, key_textHeight -5, Color(0, 0, 0, 150))
    	draw.RoundedBox(4, pos.x-5, pos.y+3, key_textWidth + 10, key_textHeight -5, Color(255, 80, 80))
    	draw.SimpleText(keyIndicatorText, "DermaLarge", pos.x, pos.y, color_white)
    	draw.SimpleText("Parçala", "DermaLarge", pos.x + 25, pos.y, color_white)
    end
end)


