--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Chaînes Vortigaunt (faux)"
ITEM.description = "Un métal qui lie et entretoise qui resserre les membres et rend les mouvements douloureux. Ils sont verrouillés en place et ne peuvent pas être retirés une fois appliqués.."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/vortigaunt_shackles.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "Legs"
ITEM.factionList = {FACTION_VORT}
ITEM.KeepOnDeath = true

ITEM.bodyGroups = {
    ["shackles"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

if (CLIENT) then
	function ITEM:GetName()
		if LocalPlayer():GetCharacter() then
			if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP or LocalPlayer():GetCharacter():GetFaction() == FACTION_VORT then
				return self.name
			end
		end

		return string.sub( self.name, 1, string.len(self.name) - 7 )
	end
end