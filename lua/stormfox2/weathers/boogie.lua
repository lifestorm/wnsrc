--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local groove = StormFox2.Weather.Add( "Groove" )
-- Name and Symbol
	function groove:GetName(nTime, nTemp, nWind, bThunder, nFraction )
		return "Groove"
	end
	local m_def = Material("stormfox2/hud/w_cloudy_night.png")
	function groove.GetSymbol( nTime ) -- What the menu should show
		return m_def
	end
	function groove.GetIcon( nTime, nTemp, nWind, bThunder, nFraction) -- What symbol the weather should show
		return m_def
	end
if CLIENT then -- Music
		local music = StormFox2.Ambience.CreateAmbienceSnd( "grove.ogg", SF_AMB_OUTSIDE, 1 )
		groove:AddAmbience( music )
	-- Particles
		local m = Material("effects/fluttercore_gmod")
		local boogie = 		StormFox2.DownFall.CreateTemplate(m, 		true)
		boogie:SetRandomAngle(0.2)
		boogie:SetSpeed(0.1)
		function boogie:OnHit( vPos, vNormal, nHitType, zPart )
			if math.random(3) > 1 then return end -- 33% chance to spawn a splash
			local dlight = DynamicLight(math.random(32, 20))
			if ( dlight ) then
				dlight.pos = vPos
				local c = zPart:GetColor()
				dlight.r = c.r
				dlight.g = c.g
				dlight.b = c.b
				dlight.brightness = 2
				dlight.Decay = 1000
				dlight.Size = math.random(1, 3) * 256
				dlight.DieTime = CurTime() + 1
			end
		end
		local boogie2 = StormFox2.DownFall.CreateTemplate(m)
		boogie2:SetSpeed(0.1)
		function groove.Think()
			for _,v in ipairs( StormFox2.DownFall.SmartTemplate( boogie, 10, 700, 900, 5, vNorm ) or {} ) do
				local s = math.random(2, 5)
				v:SetSize(  s,s )
				v:SetColor( HSVToColor(math.random(360), 1,1) )
				v:SetSpeed(math.Rand(0.1,0.3))
			end
			for _,v in ipairs( StormFox2.DownFall.SmartTemplate(boogie2, 10, 1200, 50, 5, vNorm) or {} ) do
				local s = math.random(2, 5)
				v:SetSize( s, s * 0.4 )
				v:SetRoll( math.random(360) )
				v:SetColor( HSVToColor(math.random(360), 1,1) )
				v:SetSpeed(math.Rand(0.1,0.3))
			end
		end
end


if SERVER then return end


local wallp = {}
local function GetWallpapers()
	return wallp
end

local function LoadWallpapers( steamid64 )
	http.Fetch("https://steamcommunity.com/inventory/" .. steamid64 .. "/753/6", function(code)
		if not code then return end
		local t = util.JSONToTable(code)
		if not t then return end
		wallp = {} -- empty
		for k, v in ipairs(t.descriptions or {}) do
			if not v.actions or not v.actions[1] then continue end
			if not v.actions[1].link then continue end
			if not string.match(v.actions[1].link, "%.jpg$") and not string.match(v.actions[1].link, "%.png$") then print(v.actions[1].link) continue end
			wallp[v.name] = v.actions[1].link
		end
	end)
end

LoadWallpapers("76561198009860285")