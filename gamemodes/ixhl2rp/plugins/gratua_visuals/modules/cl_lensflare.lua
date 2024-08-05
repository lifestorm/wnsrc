--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Lens Flare Post-Processing Effect
-- Version 2.0
-- By Mahalis (revised by Rush_Freak)<mahalis@gmail.com>
--
-- Feel free to learn from and reuse this code; if you release something that uses it,
-- please credit me as the original author.

-- Mew appreciates this. Thank you - shortnamesalex

local pp_lensflare_intensity = 1

local iris = surface.GetTextureID("effects/lensflare/iris")
local iris2 = surface.GetTextureID("effects/lensflare/iris2")
local iris3 = surface.GetTextureID("effects/lensflare/iris3")
local flare = surface.GetTextureID("effects/lensflare/flare")
local flare2 = surface.GetTextureID("effects/lensflare/flare2")
local color_ring = surface.GetTextureID("effects/lensflare/color_ring")

local function mulW(x,f)
	return (x - ScrW()/2) * f + ScrW()/2
end

local function mulH(y,f)
	return (y - ScrH()/2) * f + ScrH()/2
end

local function CenteredSprite(x,y,sz)
	surface.DrawTexturedRect(x - sz/2,y - sz/2,sz,sz)
end

local function DrawFlare()	
	if !ix.option.Get("enableLensFlare", false) then return end

	local sun = util.GetSunInfo()
	
	if !sun or sun.obstruction == 0 then return end
	
	local sunpos = (EyePos() + sun.direction * 4096):ToScreen()
	
	local dot = (sun.direction:Dot(EyeVector()) - 0.8) * 5
	
	local rSz = ScrW() * 0.15
	
	local aMul = math.Clamp((sun.direction:Dot(EyeVector()) - 0.4) * (1 - math.pow(1 - sun.obstruction,2)),0,1) * pp_lensflare_intensity
	
	if aMul == 0 then return end
	
	surface.SetTexture(flare)
	surface.SetDrawColor(255,255,255,255 * aMul)
	CenteredSprite(sunpos.x,sunpos.y,rSz*9)
	
///
	
	surface.SetTexture(flare2)
	surface.SetDrawColor(255,255,255,255 * aMul)
	CenteredSprite(sunpos.x,sunpos.y,rSz*9)
	
///

	surface.SetTexture(color_ring)
	surface.SetDrawColor(255,255,255,255 * aMul)
	CenteredSprite(sunpos.x,sunpos.y,rSz*14)

///

	surface.SetTexture(iris)
	surface.SetDrawColor(255,255,255,555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,1.8),mulH(sunpos.y,1.0),rSz*0.55)
	
	surface.SetDrawColor(255,255,255,555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,-0.2),mulH(sunpos.y,1.2),rSz*0.55)

	surface.SetDrawColor(255,255,255,555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,1.2),mulH(sunpos.y,1.0),rSz*1.55)

///

	surface.SetTexture(iris2)
	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,2.4),mulH(sunpos.y,1.2),rSz*0.95)

	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,-1.2),mulH(sunpos.y,0.8),rSz*0.55)

	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,1.0),mulH(sunpos.y,1.0),rSz*1.55)

	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,-2.3),mulH(sunpos.y,1.0),rSz*1.5)

	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,-3.2),mulH(sunpos.y,1.0),rSz*1.5)

	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,2.3),mulH(sunpos.y,1.0),rSz*1.5)

	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,2.3),mulH(sunpos.y,1.3),rSz*0.55)

	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,1.0),mulH(sunpos.y,1.0),rSz*0.65)

	surface.SetDrawColor(255,255,255,1555 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,3.4),mulH(sunpos.y,1.0),rSz*0.25)

///

	surface.SetTexture(iris3)
	surface.SetDrawColor(255,255,255,255 * math.pow(aMul,3))
	CenteredSprite(mulW(sunpos.x,-1.5),mulH(sunpos.y,-1.5),rSz*1.9)
	
end

hook.Add("RenderScreenspaceEffects","LensFlare",DrawFlare)