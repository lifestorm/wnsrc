--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if ( SERVER ) then
	
	-- needed for custom vgui controls in the menu
	AddCSLuaFile( "vgui/stackercontrolpresets.lua" )
	AddCSLuaFile( "vgui/stackerdnumslider.lua" )
	AddCSLuaFile( "vgui/stackerpreseteditor.lua" )
	
	-- convenience modules
	AddCSLuaFile( "improvedstacker/improvedstacker.lua" )
	AddCSLuaFile( "improvedstacker/localify.lua" )
	
else

	-- needed for custom vgui controls in the menu
	include( "vgui/stackercontrolpresets.lua" )
	include( "vgui/stackerdnumslider.lua" )
	include( "vgui/stackerpreseteditor.lua" )

end