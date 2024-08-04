--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

if SERVER then return end

surface.CreateFont("TitleFont",
{
	font = "HalfLife2",
	size = 300,
	weight = 550,
	blursize = 1,
	scanlines = 5,
	symbol = false,
	antialias = true,
	additive = true
})

surface.CreateFont("GunFont",
{
	font = "RealBeta's Weapon Icons",
	size = 300,
	weight = 550,
	blursize = 1,
	scanlines = 5,
	symbol = false,
	antialias = true,
	additive = true
})

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	// Set us up the texture
	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 255, 220, 0, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	// Draw that mother
	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )

end