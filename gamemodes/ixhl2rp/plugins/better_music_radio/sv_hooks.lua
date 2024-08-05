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
--[[
		LUA RADIO DJ!
     ;;;;;;;;;;;;;;;;;;; 
     ;;;;;;;;;;;;;;;;;;;
     ;                 ;
     ;                 ;
     ;                 ;
     ;                 ;
     ;                 ;
     ;                 ;
     ;                 ;
,;;;;;            ,;;;;;
;;;;;;            ;;;;;;
`;;;;'            `;;;;'
]]

ix.musicRadio = ix.musicRadio or {}
ix.musicRadio.channels = ix.musicRadio.channels or {}
-- a table for managing which radio is listening to which channel, basically
-- allows us to sync up the musics
ix.musicRadio.destinations = ix.musicRadio.destinations or {}
ix.musicRadio.staticTime = 3 -- how long does static play for between tunings?
ix.musicRadio.transitionTime = 3 -- how long should the transitions between songs last for?
ix.musicRadio.radioVolume = 0.7 -- DEFAULT volume between 0 to 1 of the radios
ix.musicRadio.radioLevel = 70 -- DEFAULT volume in db of the radios
ix.musicRadio.spookMinTime = 60 * 60 -- 1 hour (minimum time between spooky sfx)
ix.musicRadio.spookChance = 99999 -- probability (/second) of spooky sfx playing (after minimum time)
ix.musicRadio.dspPreset = 2 -- ROOM EMPTY SMALL BRIGHT https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index67df-2.html

hook.Add("EntityRemoved", "StopMusicRadioSound", function(ent)
	-- there is an undocumented engine bug which causes a memory leak here
	-- it will cause a black hole to open as soon as someone removes a music radio
	-- it will grow until EVERYTHING IS CONSUMED
	if (ent.soundCache) then
		for _, snd in pairs(ent.soundCache) do
			if (snd and snd.Stop) then
				snd:Stop()
			end
		end
	end
end)

function ix.musicRadio:ChannelIsValid(chName)
	if (!chName or !self.channels[chName] or !istable(self.channels[chName])) then
		return false
	end

	return true
end

function ix.musicRadio:ClassIsValid(class)
	if (!self.chanList[class] or !istable(self.chanList[class])) then
		return false
	end

	return true
end

-- called to totally reinitialize all the channels on X class of the music radios
function ix.musicRadio:RestartClass(class)
	if (!self.chanList[class]) then
		ErrorNoHaltWithStack("Attempted to restart uninitialized class: "..tostring(class))
		return
	end

	if (!istable(self.chanList[class])) then
		ErrorNoHaltWithStack("Attempted to restart class which has no channels: "..tostring(class))
		return
	end

	for _, chName in ipairs(self.chanList[class]) do
		self:RestartChannel(chName)
	end
end

function ix.musicRadio:RestartChannel(chName)
	if (!self:ChannelIsValid(chName)) then
		ErrorNoHaltWithStack("Attempted to restart uninitialized channel: "..tostring(chName))
		return
	end

	-- pause the channel, which will stop the current song on all the entities listening to it
	self:PauseDestination(chName, true)

	-- destroy the timer so we can start it again
	if (self.destinations[chName].timerName) then
		timer.Remove(self.destinations[chName].timerName)
	end

	-- now rebuild the channel timer
	self:StartDestination(chName)
end

-- called when a music radio tunes into a specific channel
function ix.musicRadio:TuneIn(ent, chName)
	if (!self:ChannelIsValid(chName)) then
		return
	end

	if (!self.destinations[chName] or
		!self:DestinationHasTimer(chName) or
		!self.destinations[chName].curSong
	) then
		self.destinations[chName] = {}
		self:StartDestination(chName)
	end

	self.destinations[chName][ent:EntIndex()] = ent
	ix.musicRadio:SyncEnt(chName, ent)

	self:PlayTuneStatic(ent)
end

-- called when a music radio entity turns off
-- and/or switches off of their current station
function ix.musicRadio:TuneOut(ent, chName, otherChName)
	if (!self:ChannelIsValid(chName)) then
		return
	end

	local entIndex = ent:EntIndex()
	if (!self.destinations[chName][entIndex]) then
		return
	end

	if (otherChName) then
		if (!self.destinations[otherChName]) then
			self.destinations[otherChName] = {}
			self:StartDestination(otherChName)
		end

		self.destinations[otherChName][entIndex] = ent -- < get updates on the new channel
		ix.musicRadio:SyncEnt(otherChName, ent) -- < start playing the next song
	end

	-- stop the current song
	local curSong = self.destinations[chName].curSong
	if (cursong and
		self.destinations[chName][entIndex].soundCache[curSong]
	) then
		if (!self.destinations[chName][entIndex].soundCache[curSong]:IsPlaying()) then
			self.destinations[chName][entIndex].soundCache[curSong]:Stop()
		end
	end

	self.destinations[chName][entIndex] = nil -- < no longer recieve updates on the current channel
end

-- starts timers that will auto play synced music for said channel
-- or unpauses them if theyre stopped
function ix.musicRadio:StartDestination(chName)
	if (!self:ChannelIsValid(chName)) then
		return
	end

	if (self.destinations[chName] and self.destinations[chName].paused) then
		if (!self.destinations[chName].timerName) then
			ErrorNoHaltWithStack("Attempted to unpause uninitialized channel: "..tostring(chName))
			return
		end

		timer.UnPause(self.destinations[chName].timerName)
	end

	if (self.destinations[chName].timerName and
		timer.Exists(self.destinations[chName].timerName)) then
		return
	end

	-- initialize some vars for tracking things
	self.destinations[chName].songsToNextAnn = math.random(8, 12)
	self.destinations[chName].songsSinceLastAnn = 0
	self.destinations[chName].ticksSinceLastSong = 0
	self.destinations[chName].ticksSinceLastSpook = 0
	self.destinations[chName].curSongLength = 0

	self.destinations[chName].timerName = "MusicRadioSyncTimer"..chName
	timer.Create(self.destinations[chName].timerName, 1, 0, function()
		self:TickChanRunTimer(chName)
	end)
end

function ix.musicRadio:DestinationHasTimer(chName)
	if (!self.destinations[chName].timerName) then
		return false
	end

	return timer.Exists(self.destinations[chName].timerName)
end

-- should tick every second that a channel is running to keep everything synced up!
function ix.musicRadio:TickChanRunTimer(chName)
	if (!self:ChannelIsValid(chName)) then
		return
	end

	self:CleanupNullEntities(chName)
	self:TickSpook(chName)

	self.destinations[chName].ticksSinceLastSong = self.destinations[chName].ticksSinceLastSong + 1
	local songTimeWithTrans = self.destinations[chName].curSongLength or 0- self.transitionTime
	if (self.destinations[chName].ticksSinceLastSong >= songTimeWithTrans or
		!self.destinations[chName].curSong) then

		self:PlayNextSong(chName)
	end
end

function ix.musicRadio:TickSpook(chName)
	if (!self:ChannelIsValid(chName)) then
		return
	end

	local class = self.channels[chName].class
	if (!class) then
		ErrorNoHaltWithStack("Cannot check state of spooky sounds: Channel has invalid classname!")
		return
	end

	if (!self:ClassIsEligibleForSpookySounds(class)) then
		return
	end

	if (!self.destinations[chName].ticksSinceLastSpook) then
		self.destinations[chName].ticksSinceLastSpook = 0
	end

	self.destinations[chName].ticksSinceLastSpook = self.destinations[chName].ticksSinceLastSpook + 1

	if (self.destinations[chName].ticksSinceLastSpook < self.spookMinTime) then
		return
	end

	if (math.random(1, self.spookChance) != 1) then
		return
	end

	self.destinations[chName].ticksSinceLastSpook = 0

	self:PlaySpookySound(chName)
end

function ix.musicRadio:PlaySpookySound(chName)
	local snd = self:GetNextSpook()
	for idx, _ in pairs(self.destinations[chName]) do
		if (!isnumber(idx)) then
			continue
		end
		local ent = Entity(idx)
		if (ent and IsEntity(ent)) then
			if (ent.GetVolume and ent.GetLevel) then -- is a music radio (just double checking <3)
				self:InterruptCurrentSong(ent, snd.fname, snd.length, true)
			end
		end
	end
end

function ix.musicRadio:ClassIsEligibleForSpookySounds(class)
	if (!class or !self.spooky or !self.spooky.classes) then
		return false
	end

	return self.spooky.classes[class]
end

function ix.musicRadio:GetNextSpook()
	if (!self.spooky or !self.spooky.sounds) then
		ErrorNoHaltWithStack("Attempted to roll next spooky sound when no spooky sounds were initialized!")
		return
	end

	--return self.spooky.sounds[math.random(1, #self.spooky.sounds)]
	return self.spooky.sounds[7]
end

function ix.musicRadio:CleanupNullEntities(chName)
	--[[
		Fixes null entities subscribed to the channel
	]]
	if (!self:ChannelIsValid(chName)) then
		return
	end

	for idx, ent in pairs(self.destinations[chName]) do
		local _idx = tonumber(idx)
		if (_idx) then
			if (!IsValid(Entity(_idx))) then
				self.destinations[chName][idx] = nil
			end
		end
	end
end

function ix.musicRadio:PlaySoundOnClass(soundName, className, length)
	if (!soundName or string.len(soundName) < 1) then
		return
	end

	if (!className or string.len(className) < 1 or !self.chanList[className]) then
		return
	end

	if (length < 1) then
		return
	end

	for i, chanName in ipairs(self.chanList[className]) do
		if (self.destinations[chanName]) then
			self.destinations[chanName].songsSinceLastAnn = self.destinations[chanName].songsSinceLastAnn + 1

			self:PlayOnAllEnts(chanName, soundName)

			self.destinations[chanName].curSong = soundName
			self.destinations[chanName].curSongLength = length
			self.destinations[chanName].ticksSinceLastSong = 0
		end
	end
end

function ix.musicRadio:SeekClass(className)
	for i, chanName in ipairs(self.chanList[className]) do
		if (self.destinations[chanName]) then
			self:PlayNextSong(chanName)
		end
	end
end

function ix.musicRadio:PlayNextSong(chName)
	-- current song over, time to start another one ;)
	-- or we haven't started a song yet
	-- reminder: the songs have baked in fade in/out which is why we do it this way
	local snd

	-- get class ;)
	local class = self.channels[chName].class
	if (!class) then
		ErrorNoHaltWithStack("Cannot play next song: Channel has invalid classname!")
		return
	end

	-- check if we're disabled
	if (self:GetClassShouldPlayStatic(class)) then
		snd = self.static.sounds[math.random(1, #self.static.sounds)]

	-- check to see if its time for an announcement ;)
	elseif (self.destinations[chName].songsSinceLastAnn >= self.destinations[chName].songsToNextAnn) then
		-- its time!
		snd = self:GetNextAnnouncement(chName)
		if (snd) then
			self.destinations[chName].songsSinceLastAnn = 0
			self.destinations[chName].songsToNextAnn = math.random(8, 12)
		else
			-- no announcement for this class
			snd = self:GetNextSong(chName)
			self.destinations[chName].songsSinceLastAnn = self.destinations[chName].songsSinceLastAnn + 1
		end
	else
		-- its not time yet, play a song instead ;(
		snd = self:GetNextSong(chName)
		self.destinations[chName].songsSinceLastAnn = self.destinations[chName].songsSinceLastAnn + 1
	end

	self:PlayOnAllEnts(chName, snd.fname)

	self.destinations[chName].curSong = snd.fname
	self.destinations[chName].curSongLength = snd.length
	self.destinations[chName].ticksSinceLastSong = 0
end

-- returns the next announcement as it exists in the channel list. aka: 
-- { fname = "filename", length = 420 seconds }
function ix.musicRadio:GetNextAnnouncement(chName)
	if (!self:ChannelIsValid(chName)) then
		return
	end

	if (!self.channels[chName].class) then
		ErrorNoHaltWithStack("Attempted to roll next announcement on channel with no class: "..tostring(chName))
		return
	end

	local class = self.channels[chName].class
	if (!self.announcements[class] or !self.announcements[class].sounds) then
		return
	end

	local nextSnd
	-- prevent the same song from playing twice:
	for i=1, 10 do
		nextSnd = self.announcements[class].sounds[math.random(1,
			table.Count(self.announcements[class].sounds)) or 1]

		if (nextSnd.fname != self.channels[chName].curSong) then
			return nextSnd
		end
	end

	-- just reroll one more time and hope it isn't the same song ;)
	return self.announcements[class].sounds[math.random(1, self.announcements[class].sounds)]
end

-- pause destination timers, which can be started again with self:StartDestination
function ix.musicRadio:PauseDestination(chName, bHardStop)
	if (bHardStop == nil) then
		bHardStop = true
	end

	if (!self:ChannelIsValid(chName)) then
		return
	end

	if (!self.destinations[chName] or self.destinations[chName].paused) then
		ErrorNoHaltWithStack("1Attempted to pause uninitialized channel: "..tostring(chName))
		return
	end

	if (!self.destinations[chName].timerName) then
		ErrorNoHaltWithStack("2Attempted to pause uninitialized channel: "..tostring(chName))
		return
	end

	timer.Pause(self.destinations[chName].timerName)
	if (bHardStop) then
		local curSong = self.destinations[chName].curSong
		for idx, _ in pairs(self.destinations[chName]) do
			if (!isnumber(idx)) then
				continue
			end
			local ent = Entity(idx)
			if (ent.soundCache and ent.soundCache[curSong]) then
				if (ent.soundCache[curSong]:IsPlaying()) then
					ent.soundCache[curSong]:Stop()
				end
			end
		end

		self.destinations[chName].ticksSinceLastSong = 0
		self.destinations[chName].curSongLength = 0
	end
end

-- play sound for specified entity at the current time; sync
-- because we have no way to 'seek' the track forward, just start at the beginning
-- and then it'll sync up when the next song plays
function ix.musicRadio:SyncEnt(chName, ent)
	if (!self:ChannelIsValid(chName)) then
		return
	end
	if (self.destinations[chName].curSong) then
		self:PlayOnEnt(chName, self.destinations[chName].curSong, ent,
			ent:GetVolume() or self.radioVolume, ent:GetLevel() or self.radioLevel)
	end
end

function ix.musicRadio:PlayOnEnt(chName, fileName, ent, vol, db)
	if (!self:ChannelIsValid(chName)) then
		ErrorNoHaltWithStack("Attempt to play on entity in invalid channel: "..tostring(chName))
		return
	end

	if (!fileName or string.len(fileName) < 1) then
		ErrorNoHaltWithStack("Invalid filename provided: "..tostring(fileName))
		return
	end

	if (!ent or !IsValid(ent) or !ent:IsValid()) then
		ErrorNoHaltWithStack("Invalid entity provided to channel: "..tostring(chName))
		return
	end

	local idx = ent:EntIndex()
	if (!self.destinations[chName][idx]) then
		ErrorNoHaltWithStack("Attempt to play on entity not in channel! ID: "..tostring(idx))
		return
	end

	if (!self.destinations[chName][idx].soundCache or
		!istable(self.destinations[chName][idx].soundCache)
	) then
		self.destinations[chName][idx].soundCache = {}
	end

	local curSound = self.destinations[chName][idx].curSound -- string filename of the sound.
	if (curSound and
		self.destinations[chName][idx].soundCache[curSound] and -- string filename indexes the sound cache
		self.destinations[chName][idx].soundCache[curSound]:IsPlaying()
	) then
		-- fade out the current track..
		self.destinations[chName][idx].soundCache[curSound]:FadeOut(self.transitionTime)
	end

	if (self.destinations[chName][idx].soundCache[fileName]) then
		-- cache hit
		if (!self.destinations[chName][idx].soundCache[fileName]:IsPlaying()) then
			-- stop the song if its already playing
			self.destinations[chName][idx].soundCache[fileName]:Stop()
		end
	else
		-- cache miss

		-- by default CreateSound networks with the PAS of the sound
		-- instead, we want to network it to everyone
		self.destinations[chName][idx].soundCache[fileName] = CreateSound(ent,
			fileName, RecipientFilter():AddAllPlayers())

		-- clean the cache
		for snd, csnd in pairs(self.destinations[chName][idx].soundCache) do
			if (csnd != curSound and snd != fileName and !csnd:IsPlaying()) then
				self.destinations[chName][idx].soundCache[snd] = nil
			end
		end
	end

	self.destinations[chName][idx].soundCache[fileName]:SetSoundLevel(ent:GetLevel() or db)
	--[[
		NOTE: There is a memory issue in SetDSP that FP knows about but refuses to fix!!!!
		If there are too many CSoundPatches with an active DSP set on them playing in one room it will overrun the client's audio buffer.
		This makes the game run at like 2fps and it sounds like someone put a microphone in a blender.
	]]
	self.destinations[chName][idx].soundCache[fileName]:SetDSP(self.dspPreset)

	self.destinations[chName][idx].soundCache[fileName]:PlayEx(ent:GetVolume() or vol, 100)

	self.destinations[chName][idx].curSound = fileName
end

-- play sound for all chan ents listening to a particular channel
function ix.musicRadio:PlayOnAllEnts(chName, fileName, vol, db)
	if (!fileName or string.len(fileName) < 1) then
		ErrorNoHaltWithStack("Attempt to play empty or nil filename!")
		return
	end

	if (!self:ChannelIsValid(chName)) then
		ErrorNoHaltWithStack("Attempt to play with invalid channel: "..tostring(chName))
		return
	end

	for idx, _ in pairs(self.destinations[chName]) do
		if (!isnumber(idx)) then
			continue
		end
		local ent = Entity(idx)
		if (ent and IsEntity(ent)) then
			if (ent.GetVolume and ent.GetLevel) then -- is a music radio
				ix.musicRadio:PlayOnEnt(chName, fileName, ent,
					ent:GetVolume() or vol or self.radioVolume,
					ent:GetLevel() or db or self.radioLevel)
			end
		end
	end
end

-- returns the next song as it exists in the channel list. aka: 
-- { fname = "filename", length = 420 seconds }
function ix.musicRadio:GetNextSong(chName)
	if (!self:ChannelIsValid(chName)) then
		ErrorNoHaltWithStack("Cannot play next song: Channel is invalid!")
		return
	end

	local nextSong
	-- prevent the same song from playing twice:
	for i=1, 10 do
		nextSong = self.channels[chName].songs[math.random(1, #self.channels[chName].songs)]
		if (nextSong.fname != self.channels[chName].curSong) then
			return nextSong
		end
	end

	-- just reroll one more time and hope it isn't the same song ;)
	return self.channels[chName].songs[math.random(1, #self.channels[chName].songs)]
end

-- plays a random splurt of static on the musicradio entity
function ix.musicRadio:PlayTuneStatic(ent, maxVol)
	if (!ent or !ent.EmitSound) then
		return
	end
	local staticFName = "willardnetworks/musicradio/musicradio_static_"..tostring(math.random(1, 6)..".mp3")

	self:InterruptCurrentSong(ent, staticFName, self.staticTime, maxVol)
end

function ix.musicRadio:InterruptCurrentSong(ent, fName, time, maxVol)
	local vol = ent:GetVolume() or self.radioVolume
	if (maxVol) then
		vol = 1
	end

	local chan = ent:GetNWString("curChan", "")
	local curVol = ent:GetNWInt("vol", 1)
    local curLvl = ent:GetNWInt("db", 70)
	ent:SetNWInt("vol", 0.1) -- just in case ;)
	local curSound = self.destinations[chan].curSong
	if (ent.soundCache) then
		ent.soundCache[curSound]:ChangeVolume(0.05, 1)
		ent.soundCache[curSound]:SetSoundLevel(60)
	end

	ent:EmitSound(fName,
		ent.db or self.radioLevel, 100, vol)

	timer.Simple(time, function()
		if (ent and IsValid(ent)) then
			ent:StopSound(fName)

			if (!ent.soundCache) then
				return
			end

			chan = ent:GetNWString("curChan", "")
			local curSoundNow = self.destinations[chan].curSong
			ent:SetNWInt("vol", curVol)
			ent.soundCache[curSoundNow]:ChangeVolume(curVol, 1) -- turn the old song back up
			ent.soundCache[curSoundNow]:SetSoundLevel(curLvl)
		end
	end)
end

function ix.musicRadio:InstallTuner(client, isPirate)
	local char = client:GetCharacter()
	local trace = client:GetEyeTraceNoCursor()
	local ent = trace.Entity

	if (!ent or !IsValid(ent)) then
		client:Notify("You are not looking at anything!")
		return
	end

	if (!ent.SetVolume or !ent.GetRadioClass) then
		client:Notify("The device you are looking at is not a music radio!")
		return
	end

	local curCls = ent:GetRadioClass()
	if (isPirate and curCls == "pirate") then
		client:Notify("This radio is already tuned to the pirate frequencies!")
		return
	elseif (!isPirate and curCls == "benefactor") then
		client:Notify("This radio is already tuned to the benefactor frequencies!")
		return
	end

	local lvl = char:GetSkill("crafting")
	if (lvl < 10) then
		client:Notify("Your crafting skill is too low to perform this action.")
		return
	end

	local cls = isPirate and "pirate" or "benefactor"
	-- 'turn off' the radio
	ent:StopCurrentSong()
	ix.musicRadio:TuneOut(ent, ent:GetChan())
	ent:SetNWString("curChan", "")

	-- set the new class
	ent:SetRadioClass(cls)

	client:SetAction("Tuning...", 3, function()
		-- tune it to the new class
		ent:SetNWString("curChan", ent.defaultStation)
		ix.musicRadio:TuneIn(ent, ent.defaultStation)
	end)
end

local function OnSave(entity, data)
	if (!IsValid(entity) or !entity.GetRadioClass) then
		ErrorNoHaltWithStack("Attempted to save invalid entity as a radio!")
		return
	end

	data.radioClass = entity:GetRadioClass() or "benefactor"
end

local function OnRestore(entity, data)
	if (!IsValid(entity) or !entity.GetRadioClass) then
		ErrorNoHaltWithStack("Attempted to restore invalid entity as a radio!")
		return
	end

	if (!data.radioClass) then
		data.radioClass = "benefactor"
	end

	entity:SetRadioClass(data.radioClass)
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("wn_musicradio", true, true, true, {
		OnSave = OnSave,
		OnRestore = OnRestore
	})
end

-- Called when loading all the data that has been saved.
function PLUGIN:LoadData()
	if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

	if (!istable(ix.musicRadio.static)) then
		ix.musicRadio.static = {}
	end

 	-- might as well load up the static classes here too
	ix.musicRadio.static.classes = ix.musicRadio:GetSavedStatic()

	for _, v in ipairs(ix.data.Get("musicRadios") or {}) do
		local entity = ents.Create(v.class)
		entity:SetPos(v.pos)
		entity:SetAngles(v.angles)
		entity:Spawn()

		entity:SetSolid(SOLID_OBB)
		entity:PhysicsInit(SOLID_OBB)

		local physObj = entity:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ix.musicRadio:GetClassShouldPlayStatic(className)
	if (!self:ClassIsValid(className)) then
		ErrorNoHaltWithStack("Attempted to get static state on invalid class: "..tostring(className))
		return
	end

	if (!istable(self.static)) then
		self:InitStatic()
	end

	if (!istable(self.static.classes)) then
		self.static.classes = ix.musicRadio:GetSavedStatic()
	end

	if (self.static.classes[className] == nil) then
		-- hasn't been set yet
		self.static.classes[className] = self.CHAN_ENABLED
		self:SaveStatic() -- save the new default
	end

	if (self.static.classes[className] == self.CHAN_DISABLED) then
		return true
	else
		return false
	end
end

-- sets a class of radio as 'disabled' so that it only plays static.
function ix.musicRadio:SetClassStaticState(className, state)
	if (!self:ClassIsValid(className)) then
		ErrorNoHaltWithStack("Attempted to set static state on invalid class: "..tostring(className))
		return
	end

	self.static.classes[className] = state

	if (state == self.CHAN_DISABLED) then
		-- immediately start playing static on all the radios of this class
		self:PlaySoundOnClass(self.static.sounds[math.random(1, #self.static.sounds)].fname,
			className, 55)
	else
		self:RestartClass(className) -- otherwise, restart the classes channels
	end

	self:SaveStatic()
end

-- get the static classes from data folder
function ix.musicRadio:GetSavedStatic()
	local jsonDat = file.Read("musicradio/static.json", "DATA")
	local tab = util.JSONToTable(jsonDat or "{}")

	if (!tab or !istable(tab)) then
		ErrorNoHaltWithStack("Unable to load saved musicradio static")
		return
	end

	return tab
end

-- save the current state to data folder
function ix.musicRadio:SaveStatic()
	local tab = util.TableToJSON(self.static.classes or {})
	file.CreateDir("musicradio")
	file.Write("musicradio/static.json", tab)
end
