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

ITEM.name = "Pin"
ITEM.uniqueID = "pin"
ITEM.model = "models/items/crossbowrounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A pin. Used to hang up papers etc. on the walls."
ITEM.category = "Writing"

function ITEM:MakeNail(nailedEnt, pos, ang, client)
	pos = nailedEnt:LocalToWorld( pos )
	nailedEnt:GetPhysicsObject():EnableMotion(false)

	local nail = ents.Create( "gmod_nail" )
	nail:SetPos( pos )
	nail:SetAngles( ang )
	nail:SetParent( nailedEnt )

	nail:Spawn()
	nail:Activate()

	local item = ix.item.instances[nailedEnt.ixItemID]
	item:SetData("pin", true)
	item:SetData("owner", client:GetCharacter():GetID())
	nail.itemparentID = nailedEnt.ixItemID
	nail.itemparentPos = nailedEnt:GetPos()
	nail.itemparentAngs = nailedEnt:GetAngles()

	ix.saveEnts:SaveEntity(nail)
end

ITEM.functions.Pin = {
	OnRun = function(item)
		local client = item.player

		local trace = client:GetEyeTrace()

		-- Bail if we hit world or a client
		if (  !trace.Entity:IsValid() or trace.Entity:IsPlayer() ) then return false end

		if ( SERVER and !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

		local tr = {}
			tr.start = trace.HitPos
			tr.endpos = trace.HitPos + (client:GetAimVector() * 16.0)
			tr.filter = { client, trace.Entity }
		local trTwo = util.TraceLine( tr )

		if ( trTwo.Hit and !trTwo.Entity:IsPlayer() ) then
			if trace.Entity:GetClass() != "ix_item" then
				client:NotifyLocalized("Only items can be pinned!")
				return false
			end

			-- Client can bail now
			if ( CLIENT ) then return true end

			local vOrigin = trace.HitPos - (client:GetAimVector() * 8.0)
			local vDirection = client:GetAimVector():Angle()

			vOrigin = trace.Entity:WorldToLocal( vOrigin )
			item:MakeNail( trace.Entity, vOrigin, vDirection, client )
			client:EmitSound("weapons/crossbow/hit1.wav", 110)
		else
			client:NotifyLocalized("Could not find anything to pin!")
			return false
		end
	end
}
