--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function ENT:StoreCPPI( owner )
	self._OwnerEntLVS = owner
end

function ENT:TransferCPPI( target )
	if not IsEntity( target ) or not IsValid( target ) then return end

	if not CPPI then return end

	local Owner = self._OwnerEntLVS

	if not IsEntity( Owner ) then return end

	if IsValid( Owner ) then
		target:CPPISetOwner( Owner )
	end
end
