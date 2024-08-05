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
if (PLUGIN.active == nil) then
	PLUGIN.active = false
else
	PLUGIN.active = PLUGIN.active
end

local DRUG_NUM_OF_SONGS = 5

PLUGIN.music = {
  "https://willard.network/game/drugs/oasis.mp3",
  "https://willard.network/game/drugs/iloveit.mp3",
  "https://willard.network/game/drugs/silhouettes.mp3",
  "https://willard.network/game/drugs/nero.mp3",
  "https://willard.network/game/drugs/greyhound.mp3",
  "https://willard.network/game/drugs/ruiner.mp3",
  "https://willard.network/game/drugs/majesty.mp3",
  "https://willard.network/game/drugs/blahblahblah.mp3",
  "https://willard.network/game/drugs/desire.mp3",
  "https://willard.network/game/drugs/tidalwave.mp3",
  "https://willard.network/game/drugs/solarsystem.mp3",
  "https://willard.network/game/drugs/skrillex.mp3",
}

net.Receive("ixSapphireDrug", function(len)
	if (net.ReadBool()) then
		PLUGIN:Apply()
	else
		PLUGIN:Clear()
	end
end)

function PLUGIN:GetEntityTargets()
	local entities = ents.GetAll()
	local targets = {}
	for i = 1, #entities do
		local ent = entities[i]
		if (!IsValid(ent)) then continue end
		if (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then
			targets[#targets + 1] = ent
		end
	end

	return targets
end

function PLUGIN:Apply()
	self.songs = 0

	if (!self.active) then
		self.nextFlash = 0
		self.active = true

		if (ix.option.Get("drugEffects", true) == false) then

			return
		end

		LocalPlayer():ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 3, 1)
		self:Music()
	end
end

function PLUGIN:Clear()
	self.active = false
	if (self.sound ~= nil and IsValid(self.sound)) then
		self.sound:Stop()
		self.sound = nil
	end

	timer.Remove("ixSapphireMusic")

	for k, v in ipairs(self:GetEntityTargets()) do
		v:DisableMatrix("RenderMultiply")
	end
end

function PLUGIN:Music()
	if (!self.active) then return end

	if (self.songs >= math.min(#self.music, DRUG_NUM_OF_SONGS)) then
		net.Start("ixSapphireDrug")
		net.SendToServer()
		return
		--self:Clear(LocalPlayer())
	end

	if (!self.toPlay or #self.toPlay == 0) then
		self.toPlay = {}
		for i = 1, #self.music do self.toPlay[i] = i end
	end

	local random = math.random(1, #self.toPlay)
	local url = self.music[self.toPlay[random]]
	table.remove(self.toPlay, random)

	sound.PlayURL(url, "noplay", function (s, errId, err)
		if (!s and self.fails < 5) then
			-- If this fails, try another.
			self.fails = (self.fails or 0) + 1
			return self:Music()
		end

		self.fails = 0
		self.sound = s
		s:Play()
		s:SetVolume(2.0)

		self.songs = self.songs + 1
		self.song = url

		timer.Create("ixSapphireMusic", s:GetLength(), 1, function () self:Music() end)
	end)
end

function PLUGIN:FFTFlash(triggerBands, threshold)
	if (not self.sound or not IsValid(self.sound) or self.sound:GetState() ~= GMOD_CHANNEL_PLAYING) then
		return false
	end

	local s = self.sound
	local bands = {}
	local bandThickness = 18
	local bandMaxHeight = ((ScrH()/3) * 2) - 75
	local amp = 5000
	local dext = 2
	local offset = 0
	local realBands = {}

	self.sound:FFT(bands , FFT_8192)
	for i = 1 , 64 do
		if (bands[i + offset] * amp > bandMaxHeight) then
			bands[i + offset] = bandMaxHeight / amp
		end

		if (bands[i + offset] * amp < 2) then
			bands[i + offset] = 2
		else
			bands[i + offset] = bands[i + offset] * amp
		end

		realBands[i] = Lerp(30*FrameTime(),realBands[i] or 0,bands[i + offset])
		if (i < 63  and i > 2) then
			local a = realBands[i] or 0
			local b = realBands[i + 1] or 0
			local c = realBands[i - 1] or 0
			realBands[i] = (a+b+c) / 3
		elseif (i < 3) then
			local a = realBands[i] or 0
			local b = realBands[i + 1] or 0
			local c = 0
			realBands[i] = (a+b+c) / 3
		end
	end

	--print(sum)
	--print(realBands[15])
	local amp2 = 0
	for k, v in pairs(triggerBands) do
		amp2 = amp2 + realBands[v]
	end

	if (amp2 > threshold and CurTime() > self.nextFlash) then
		LocalPlayer():ScreenFade(SCREENFADE.IN, Color(math.Rand(200, 255), math.Rand(200, 255), math.Rand(200, 255), 80), 0.4, 0)

		self.nextFlash = CurTime() + 0.2

		-- Light
		local dl = DynamicLight(LocalPlayer():EntIndex())
		if (dl) then
			dl.pos = LocalPlayer():GetPos()
			dl.r = 255
			dl.g = 192
			dl.b = 255
			dl.brightness = 2
			dl.Decay = 1000
			dl.Size = 4096
			dl.DieTime = CurTime() + 1.0
		end

		self.dl = dl
		local scaleMatrix = Matrix()
		local factor = math.Clamp(1 + math.sin(CurTime()), 0.4, 0.8)
		scaleMatrix:Scale(Vector(factor, factor, factor))

		for k, v in ipairs(self:GetEntityTargets()) do
			v:EnableMatrix("RenderMultiply", scaleMatrix)
		end
	end
end