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

PLUGIN.name = "Ambient"
PLUGIN.description = "Ambient Sounds"
PLUGIN.author = "DrodA"
PLUGIN.version = 1.0

ix.option.Add("enableAmbient", ix.type.bool, true, {
	category = "Background Music",
	OnChanged = function(old_value, new_value)
		if (!new_value) then
			PLUGIN:StopSound()

			return
		end

		PLUGIN:PlaySound(PLUGIN.ambients[math.random(1, #PLUGIN.ambients)])
	end
})

ix.option.Add("ambientVolume", ix.type.number, 0.7, {
	category = "Background Music",
	min = 0.1, max = 1, decimals = 1,
	OnChanged = function(old_value, new_value)
		PLUGIN:SetVolume(new_value)
	end
})

ix.lang.AddTable("english", {
    optAmbientVolume = "Ambient music volume",
    optdAmbientVolume = "How loud the volume of the ambient music should be.",
    optEnableAmbient = "Enable ambient music",
    optdEnableAmbient = "Whether or not the ambient music should be enabled."
})

if (SERVER) then return end

local timer_id = "ix_ambient_track"

PLUGIN.ambients = {
	{path = "music/passive/passivemusic_01.ogg", length = 85},
	{path = "music/passive/passivemusic_02.ogg", length = 130},
	{path = "music/passive/passivemusic_03.ogg", length = 95},
	{path = "music/passive/passivemusic_04.ogg", length = 125},
	{path = "music/passive/passivemusic_05.ogg", length = 215},
	{path = "music/passive/passivemusic_06.ogg", length = 210},
	{path = "music/passive/passivemusic_07.ogg", length = 245},
	{path = "music/passive/passivemusic_08.ogg", length = 268},
	{path = "music/passive/passivemusic_09.ogg", length = 150},
	{path = "music/passive/passivemusic_10.ogg", length = 260},
	{path = "music/passive/passivemusic_11.ogg", length = 340},
	{path = "music/passive/passivemusic_12.ogg", length = 260},
	{path = "music/passive/passivemusic_13.ogg", length = 440},
	{path = "music/passive/passivemusic_14.ogg", length = 130},
	{path = "music/passive/passivemusic_15.ogg", length = 130},
	{path = "music/passive/passivemusic_16.ogg", length = 250},
	{path = "music/passive/passivemusic_17.ogg", length = 270},
	{path = "music/passive/passivemusic_18.ogg", length = 320},
	{path = "music/passive/passivemusic_19.ogg", length = 100},
	{path = "music/passive/passivemusic_20.ogg", length = 210}
}

for _, v in pairs(PLUGIN.ambients) do
	util.PrecacheSound(v.path)
end

function PLUGIN:StopSound()
	if (timer.Exists(timer_id)) then
		timer.Remove(timer_id)
	end

	if (self.ambient) then
		self.ambient:Stop()
		self.ambient = nil
	end
end

function PLUGIN:SetVolume(volume)
	if !self.ambient then return end

	self.ambient:ChangeVolume(volume)
end

function PLUGIN:PlaySound(data)
	if (!ix.option.Get("enableAmbient")) then
		self:StopSound()
		return
	end

	if (timer.Exists(timer_id)) then
		self:StopSound()
	end

	self.ambient = CreateSound(LocalPlayer(), data.path)
	self.ambient:Play()
	self.ambient:ChangeVolume(ix.option.Get("ambientVolume"), 0)

	timer.Create(timer_id, data.length, 1, function()
		PLUGIN:StopSound()

		timer.Simple(math.random(30, 60), function()
			PLUGIN:PlaySound(PLUGIN.ambients[math.random(1, #PLUGIN.ambients)])
		end)
	end)
end

function PLUGIN:CharacterLoaded(character)
	if (!timer.Exists(timer_id) and ix.option.Get("enableAmbient")) then
		self:PlaySound(PLUGIN.ambients[math.random(1, #PLUGIN.ambients)])
	end
end

function PLUGIN:PostPlaySound(sound, isGlobal)
	if (isGlobal) then
		self:StopSound()

		timer.Simple(SoundDuration(sound) + math.random(30, 60), function()
			PLUGIN:PlaySound(PLUGIN.ambients[math.random(1, #PLUGIN.ambients)])
		end)
	end
end
