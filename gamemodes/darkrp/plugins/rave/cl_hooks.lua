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

local haloColor = haloColor
function PLUGIN:PreDrawHalos()
	if (!self.active) then return end

	if (CurTime() > self.nextFlash) then
		haloColor = Color(math.Rand(0, 255), math.Rand(0, 255), math.Rand(0, 255))
	end

	if (haloColor) then
		halo.Add(self:GetEntityTargets(), haloColor, 1, 32, 32, true, false)
	end
end

function PLUGIN:RenderScreenspaceEffects()
	if (!self.active) then return end

	local tab = {}
	tab[ "$pp_colour_addr" ] = 0
	tab[ "$pp_colour_addg" ] = 0
	tab[ "$pp_colour_addb" ] = 0
	//tab[ "$pp_colour_brightness" ] = 0
	//tab[ "$pp_colour_contrast" ] = 1
	tab[ "$pp_colour_mulr" ] = 0
	tab[ "$pp_colour_mulg" ] = 0
	tab[ "$pp_colour_mulb" ] = 0

	tab[ "$pp_colour_colour" ] =   5
	tab[ "$pp_colour_brightness" ] = -0.21
	tab[ "$pp_colour_contrast" ] = 0.5

	DrawColorModify( tab )

	--DrawMotionBlur(0.1,1,0.01)
	--DrawMaterialOverlay("effects/water_warp01",-0.1)
	DrawSharpen(5,5)
	DrawBloom(0,0.4,0,0,10,20,1,1,1)
	--DrawSobel(0.15)
end

function PLUGIN:Think()
	if (!self.active) then return end

	self:FFTFlash({14, 15, 16}, 300)
end