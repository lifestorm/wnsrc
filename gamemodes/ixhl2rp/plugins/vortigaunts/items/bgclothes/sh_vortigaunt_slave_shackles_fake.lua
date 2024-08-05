--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Vortigaunt Shackles (fake)"
ITEM.description = "Metal binds and braces that constrict the limbs and make it painful to move. They are locked in place and cannot be removed once applied."
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