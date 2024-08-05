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
PLUGIN.name = "Better Music Radio"
PLUGIN.author = "M!NT"
PLUGIN.description = "Adds a radio that plays music, but better c:"

ix.util.Include("sv_hooks.lua")
ix.util.Include("cl_hooks.lua")

ix.musicRadio = ix.musicRadio or {}
ix.musicRadio.announcements = ix.musicRadio.annnouncements or {}
ix.musicRadio.channels = ix.musicRadio.channels or {}
ix.musicRadio.classes = ix.musicRadio.classes or {
	["pirate"] = "wn_rebel_radio",
	["benefactor"] = "wn_cmb_radio"
}
ix.musicRadio.static = ix.musicRadio.static or {}
ix.musicRadio.classes = ix.musicRadio.classes or {}
-- enums
ix.musicRadio.CHAN_DISABLED = true
ix.musicRadio.CHAN_ENABLED = false

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Music Radios",
	MinAccess = "admin"
})

ix.command.Add("MusicRadioChannelSeek", {
	description = "Seek the specific music radio channel forward one song.",
	privilege = "Manage Music Radios",
	adminOnly = true,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, channelName)
		if (!ix.musicRadio:ChannelIsValid(channelName)) then
			client:Notify("Invalid channel name provided!")
		else
			ix.musicRadio:PlayNextSong(channelName)
		end
	end
})

ix.command.Add("PlaySoundOnRadioClass", {
	description = "Play a specific song on all radios in a certain class on the map.",
	privilege = "Manage Music Radios",
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, class, soundName, length)
		ix.musicRadio:PlaySoundOnClass(soundName, class, length)
	end
})

ix.command.Add("SetMusicRadioClassEnabled", {
	description = "Disable a specific class of music radios.",
	privilege = "Manage Music Radios",
	adminOnly = true,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, class)
		if (!ix.musicRadio:ClassIsValid(class)) then
			client:Notify("Invalid class name provided!")
		else
			if (!ix.musicRadio:GetClassShouldPlayStatic(class)) then
				client:Notify("This class is currently enabled. Use the 'SetMusicRadioClassDisabled' command to disable it.")
			else
				ix.musicRadio:SetClassStaticState(class, ix.musicRadio.CHAN_ENABLED)
			end
		end
	end
})

ix.command.Add("SetMusicRadioClassDisabled", {
	description = "Enable a specific class of music radios.",
	privilege = "Manage Music Radios",
	adminOnly = true,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, class)
		if (!ix.musicRadio:ClassIsValid(class)) then
			client:Notify("Invalid class name provided!")
		else
			if (ix.musicRadio:GetClassShouldPlayStatic(class)) then
				client:Notify("This class is currently disabled. Use the 'SetMusicRadioClassEnabled' command to enable it.")
			else
				ix.musicRadio:SetClassStaticState(class, ix.musicRadio.CHAN_DISABLED)
			end
		end
	end
})

ix.command.Add("RestartMusicRadioClass", {
	description = "Restart a specific class of music radios (in case they crash for some reason).",
	privilege = "Manage Music Radios",
	adminOnly = true,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, class)
		if (!ix.musicRadio:ClassIsValid(class)) then
			client:Notify("Invalid class name provided!")
		else
			ix.musicRadio:RestartClass(class)
			client:Notify("Restarted class: "..class)
		end
	end
})

ix.command.Add("RestartMusicRadioChannel", {
	description = "Restart a specific radio channel (in case it crashes for some reason).",
	privilege = "Manage Music Radios",
	adminOnly = true,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, channel)
		if (!ix.musicRadio:ChannelIsValid(channel)) then
			client:Notify("Invalid channel name provided!")
		else
			ix.musicRadio:RestartChannel(channel)
			client:Notify("Restarted channel: "..channel)
		end
	end
})

function ix.musicRadio:InitStatic()
	--[[
		STATIC sounds for when the channel / class is KOd
	]]
	local static = {
		[1] = { fname = "willardnetworks/musicradio/static/musicradio_static_1.mp3", length = 55 },
		[2] = { fname = "willardnetworks/musicradio/static/musicradio_static_2.mp3", length = 55 },
		[3] = { fname = "willardnetworks/musicradio/static/musicradio_static_3.mp3", length = 55 }
	}

	self.static.sounds = static
end


function ix.musicRadio:InitSpooky()
	--[[
		Spooky sounds for fun
	]]
	local classes = {
		["pirate"] = true,
		["benefactor"] = false
	}

	local sounds = {
		[1] = { fname = "willardnetworks/musicradio/rebel/spooky/musicradio_spooky_1.mp3", length = 170 },
		[2] = { fname = "willardnetworks/musicradio/rebel/spooky/musicradio_spooky_2.mp3", length = 170 },
		[3] = { fname = "willardnetworks/musicradio/rebel/spooky/musicradio_spooky_3.mp3", length = 52 },
		[4] = { fname = "willardnetworks/musicradio/rebel/spooky/musicradio_spooky_4.mp3", length = 11 },
		[5] = { fname = "willardnetworks/musicradio/rebel/spooky/musicradio_spooky_5.mp3", length = 9 },
		[6] = { fname = "willardnetworks/musicradio/rebel/spooky/musicradio_spooky_6.mp3", length = 12 },
		[7] = { fname = "willardnetworks/musicradio/rebel/spooky/musicradio_spooky_7.mp3", length = 60 },
	}

	self.spooky = {}
	self.spooky.sounds = sounds
	self.spooky.classes = classes
end

function ix.musicRadio:PrecacheSpooky()
	if (SERVER) then
		return
	end

	if (!istable(self.spooky)) then
		return
	end

	for k, song in ipairs(self.spooky.sounds) do
		util.PrecacheSound(song.fname)
	end
end

function ix.musicRadio:AddAnnouncementsToClass(className, announcerTbl)
	if (!self.classes[className]) then
		-- happens a lot during lua refresh
		-- if that happens to you, safe to ignore
		-- just keeping this here in case an announcer class doesn't come up during refresh
		ErrorNoHaltWithStack("Attempt to add invalid announcer! Not adding.. Class: "..tostring(className))
		return
	else
		if (!self.announcements) then
			self.announcements = {}
		end

		self.announcements[className] = {}
		self.announcements[className].sounds = announcerTbl
	end
end

function ix.musicRadio:PrecacheAnnouncementsForClass(className)
	if (SERVER) then
		return
	end

	if (!istable(self.classes[className])) then
		return
	end

	for k, snd in ipairs(self.announcements[className]) do
		util.PrecacheSound(snd.fname)
	end
end

function ix.musicRadio:PrecacheChannel(chName)
	if (SERVER) then
		return
	end

	if (!istable(self.channels[chName])) then
		return
	end

	for k, song in ipairs(self.channels[chName]) do
		util.PrecacheSound(song.fname)
	end
end

-- get the 'next' channel; seek forward
function ix.musicRadio:GetNextChannelName(chName)
	local class = self.channels[chName].class
	if (!chName or chName == "") then
		return self.chanList[class][1]
	end

	local k = table.KeyFromValue(self.chanList[class], chName)

	if (k and isnumber(k)) then
		if (k == table.Count(self.chanList[class])) then
			return self.chanList[class][1] -- loop around
		else
			return self.chanList[class][k+1]
		end
	end
end

function ix.musicRadio:GetDefaultChannel(className)
	if (!self.classes[className]) then
		ErrorNoHaltWithStack("Attempt to add radio to invalid channel! Not adding.. Class: "..tostring(className))
		return
	end

	return ix.musicRadio.chanList[className][1]
end

function ix.musicRadio:AddChannel(chName, mTbl, class, freqMap)
	if (!self.classes[class]) then
		-- happens a lot during lua refresh
		-- if that happens to you, safe to ignore
		-- just keeping this here in case a channel doesn't come up during refresh
		ErrorNoHaltWithStack("Attempt to add invalid channel! Not adding.. Name: "..tostring(chName).." Class: "..tostring(class))
		return
	else
		self.channels[chName] = {}
		self.channels[chName].songs = mTbl
		self.channels[chName].freqMap = freqMap -- used clientside to figure out where the dial goes
		self.channels[chName].class = class

		if (!self.chanList) then
			self.chanList = {}
		end

		if (!self.chanList[class]) then
			self.chanList[class] = {}
		end

		table.insert(self.chanList[class], chName)
	end
end

function ix.musicRadio:GetChannel(chName)
	if (self.channels[chName] and istable(self.channels[chName])) then
		return self.channels[chName]
	end
end

--[[
	RADIO SETUP
]]
do
	-- load up the current state of static
	ix.musicRadio:InitStatic()

	-- load up some stuff for spooks
	ix.musicRadio:InitSpooky()
	ix.musicRadio:PrecacheSpooky()

	-- the static blurb that plays during tuning
	local staticSoundFilePrefix = "willardnetworks/musicradio/musicradio_static_"
	for i=1, 6 do
		util.PrecacheSound(staticSoundFilePrefix..tostring(i)..".mp3")
	end

	--[[
		REBEL RADIO STATIONS
	]]
	local bluesRock = {
		[1] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_acdc_jailbreak.mp3", length = 275 },
		[2] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_aerosmith_dreamon.mp3", length = 260 },
		[3] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_allmanbrothers_midnightrider.mp3", length = 173 },
		[4] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_allmanbrothers_whippingpost.mp3", length = 316 },
		[5] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_bbking_thrillisgone.mp3", length = 309 },
		[6] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_beatles_taxman.mp3", length = 151 },
		[7] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_billwithers_aintnosunshine.mp3", length = 118 },
		[8] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_cream_strangebrew.mp3", length = 164 },
		[9] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_dirtymac_yerblues.mp3", length = 242 },
		[10] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_jacksonbrowne_doctormyeyes.mp3", length = 186 },
		[11] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_jimihendrix_allalongthewatchtower.mp3", length = 238 },
		[12] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_jimihendrix_littlewing.mp3", length = 138 },
		[13] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_jimihendrix_purplehaze.mp3", length = 164 },
		[14] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_johnleehooker_boomboomboomboom.mp3", length = 156 },
		[15] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_ledzepplin_rambleon.mp3", length = 240 },
		[16] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_ledzepplin_stairwaytoheaven.mp3", length = 467 },
		[17] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_lynyrdskynyrd_amilosin.mp3", length = 251 },
		[18] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_lynyrdskynyrd_cryforthebadman.mp3", length = 280 },
		[19] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_lynyrdskynyrd_freebird.mp3", length = 518 },
		[20] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_lynyrdskynyrd_onthehunt.mp3", length = 315 },
		[21] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_lynyrdskynyrd_saturdaynightspecial.mp3", length = 291 },
		[22] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_srv_prideandjoy.mp3", length = 216 },
		[23] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_srv_texasflood.mp3", length = 317 },
		[24] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_srv_voodoochild.mp3", length = 455 },
		[25] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_stonetemplepilots_interstatelovesong.mp3", length = 187 },
		[26] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_tednugent_stranglehold.mp3", length = 500 },
		[27] = { fname = "willardnetworks/musicradio/rebel/bluesrock/musicradio_theband_thenighttheydroveolddixiedown.mp3", length = 247 }
	}

	local hipHop = {
		[1] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_big_hypnotize.mp3", length = 225 },
		[2] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_fugees_zealots.mp3", length = 243 },
		[3] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_getoboys_damnitfeelsgoodtobeagangasta.mp3", length = 298 },
		[4] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_getoboys_still.mp3", length = 216 },
		[5] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_heltahskeltah_lethabrainzblo.mp3", length = 243 },
		[6] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_jamoroquai_virtualinstanity.mp3", length = 223 },
		[7] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_mfdoom_doomsday.mp3", length = 247 },
		[8] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_nas_nystateofmind.mp3", length = 288 },
		[9] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_nwa_fuckdapolice.mp3", length = 313 },
		[10] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_outkast_atliens.mp3", length = 208 },
		[11] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_outkast_elevators.mp3", length = 234 },
		[12] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_peterock_troy.mp3", length = 273 },
		[13] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_puts_acidraindrops.mp3", length = 264 },
		[14] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_sugarhillgang_rappersdelight.mp3", length = 236 },
		[15] = { fname = "willardnetworks/musicradio/rebel/hiphop/musicradio_wutang_cream.mp3", length = 235 }
	}

	local country = {
		[1] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_alabama_dixielanddelight.mp3", length = 233 },
		[2] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_billmonroe_bluemoonofkentucky.mp3", length = 186 },
		[3] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_charliedaniels_southsgondoitagain.mp3", length = 235 },
		[4] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_docwatson_houseoftherisingsun.mp3", length = 193 },
		[5] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_gordonlightfoot_edmundfitzgerald.mp3", length = 351 },
		[6] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_jimmymartin_freebornman.mp3", length = 169 },
		[7] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_jimmymartin_madeintheshade.mp3", length = 181 },
		[8] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_keithwhitley_miamimyami.mp3", length = 201 },
		[9] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_oldcrow_takeemaway.mp3", length = 208 },
		[10] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_oldcrow_wagonwheel.mp3", legnth = 227 },
		[11] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_osbornebrothers_rockytop.mp3", legnth = 151 },
		[12] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_osbornebrothers_sunnysideofthemountain.mp3", legnth = 138 },
		[13] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_ralphstanely_clinchmountainbackstep.mp3", legnth = 136 },
		[14] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_ralphstanely_eastvirginiablues.mp3", legnth = 151 },
		[15] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_ralphstanely_gloryland.mp3", legnth = 160 },
		[16] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_ralphstanely_manofconstantsorrow.mp3", legnth = 165 },
		[17] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_ralphstanely_rankstranger.mp3", legnth = 208 },
		[18] = { fname = "willardnetworks/musicradio/rebel/bluegrass/musicradio_willienelson_hellowalls.mp3", legnth = 240 }
	}

	local metal = {
		[1] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_bathory_callfromthegrave.mp3", length = 260 },
		[2] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_blacksabbath_blacksabbath.mp3", length = 337 },
		[3] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_burzum_dunkelheitwav.mp3", length = 417 },
		[4] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_cannibalcorpse_hammersmashedface.mp3", length = 241 },
		[5] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_celticfrost_adyinggod.mp3", length = 336 },
		[6] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_celticfrost_cryptsofrays.mp3", length = 217 },
		[7] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_danzig_evilthing.mp3", length = 192 },
		[8] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_entombed_revelinflesh.mp3", length = 206 },
		[9] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_fearfactory_pisschrist.mp3", length = 319 },
		[10] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_mayhem_chainsawgutsfuck.mp3", length = 208 },
		[11] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_megadeth_hangar18.mp3", length = 310 },
		[12] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_megadeth_holywars.mp3", length = 390 },
		[13] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_megadeth_killingroad.mp3", length = 228 },
		[14] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_megadeth_symphonyofdestruction.mp3", length = 228 },
		[15] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_sepultura_arise.mp3", length = 197 },
		[16] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_sepultura_propaganda.mp3", length = 210 },
		[17] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_sepultura_rootsbloodyroots.mp3", length = 203 },
		[18] = { fname = "willardnetworks/musicradio/rebel/metal/musicradio_whitezombie_thunderkiss.mp3", length = 228 }
	}

	local punk = {
		[1] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_agentorange_bloodstains.mp3", length = 108 },
		[2] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_aliceinchains_maninthebox.mp3", length = 265 },
		[3] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_aliceinchains_rooster.mp3", length = 367 },
		[4] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_aliceinchains_thembones.mp3", length = 147 },
		[5] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_aliceinchains_would.mp3", length = 204 },
		[6] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_badbrains_bigtakeover.mp3", length = 177 },
		[7] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_blackflag_mywar.mp3", length = 225 },
		[8] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_blackflag_riseabove.mp3", length = 142 },
		[9] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_clutch_bingeandpurge.mp3", length = 385 },
		[10] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_eyehategod_sisterfucker.mp3", length = 120 },
		[11] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_foofighters_everlong.mp3", length = 289 },
		[12] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_foofighters_monkeywrench.mp3", length = 230 },
		[13] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_helmet_unsung.mp3", length = 235 },
		[14] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_megadeth_takenoprisoners.mp3", length = 204 },
		[15] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_melvins_junebug.mp3", length = 112 },
		[16] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_ministry_thieves.mp3", length = 297 },
		[17] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_misfits_diediediemydarling.mp3", length = 184 },
		[18] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_misfits_whereeaglesdare.mp3", length = 122 },
		[19] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_ramones_blitzkriegbop.mp3", length = 130 },
		[20] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_ratm_bornofabrokenman.mp3", length = 277 },
		[21] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_ratm_killinginthenameof.mp3", length = 312 },
		[22] = { fname = "willardnetworks/musicradio/rebel/punk/musicradio_typeoneg_idontwannabeme.mp3", length = 223 }
	}

	local alternative = {
		[1] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_aphextwin_1.mp3", length = 434 },
		[2] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_aphextwin_cockver10.mp3", length = 288 },
		[3] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_aphextwin_vordhosbn.mp3", length = 273 },
		[4] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_aphextwin_xtal.mp3", length = 273 },
		[5] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_bjork_armyofme.mp3", length = 229 },
		[6] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_massiveattack_dissolvedgirl.mp3", length = 358 },
		[7] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_massiveattack_teardrop.mp3", length = 318 },
		[8] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_nin_headlikeahole.mp3", length = 291 },
		[9] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_nin_hurt.mp3", length = 331 },
		[10] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_squarepusher_anirog09.mp3", length = 70 },
		[11] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_squarepusher_beepstreet.mp3", length = 389 },
		[12] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_squarepusher_craniumoxide.mp3", length = 29 },
		[13] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_squarepusher_decathlonoxide.mp3", length = 243 },
		[14] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_theprodigy_breathe.mp3", length = 235 },
		[15] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_theprodigy_firestarter.mp3", length = 278 },
		[16] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_whitezombie_morehumanthanhuman.mp3", length = 316 },
		[17] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_nin_bigcomedown.mp3", length = 246 },
		[18] = { fname = "willardnetworks/musicradio/rebel/alternative/musicradio_nin_thegreatbelow.mp3", length = 254 }
	}

	local pirateAnnouncer = {
		[1] = { fname = "willardnetworks/musicradio/rebel/announcer/musicradio_pirate_announce_1.mp3", length = 49 },
		[2] = { fname = "willardnetworks/musicradio/rebel/announcer/musicradio_pirate_announce_2.mp3", length = 70 },
		[3] = { fname = "willardnetworks/musicradio/rebel/announcer/musicradio_pirate_announce_3.mp3", length = 87 },
		[4] = { fname = "willardnetworks/musicradio/rebel/announcer/musicradio_pirate_announce_4.mp3", length = 92 },
		[5] = { fname = "willardnetworks/musicradio/rebel/announcer/musicradio_pirate_announce_5.mp3", length = 111 },
		[6] = { fname = "willardnetworks/musicradio/rebel/announcer/musicradio_pirate_announce_6.mp3", length = 121 },
		[7] = { fname = "willardnetworks/musicradio/rebel/announcer/musicradio_pirate_announce_7.mp3", length = 110 },
		[8] = { fname = "willardnetworks/musicradio/rebel/announcer/musicradio_pirate_announce_8.mp3", length = 98 }
	}

	-- Pirate (rebel) radio stations:
	ix.musicRadio:AddChannel("Blues & Rock", bluesRock, "pirate", {
		dispX = 195,
		freq = 550
	})
	ix.musicRadio:AddChannel("Hiphop", hipHop, "pirate", {
		dispX = 245,
		freq = 600
	})
	ix.musicRadio:AddChannel("Country", country, "pirate", {
		dispX = 295,
		freq = 650
	})
	ix.musicRadio:AddChannel("Metal", metal, "pirate", {
		dispX = 345,
		freq = 700
	})
	ix.musicRadio:AddChannel("Punk", punk, "pirate", {
		dispX = 395,
		freq = 750
	})
	ix.musicRadio:AddChannel("Alternative", alternative, "pirate", {
		dispX = 445,
		freq = 800
	})

	if (CLIENT) then
		ix.musicRadio:PrecacheChannel("Blues & Rock")
		ix.musicRadio:PrecacheChannel("Hiphop")
		ix.musicRadio:PrecacheChannel("Country")
		ix.musicRadio:PrecacheChannel("Metal")
		ix.musicRadio:PrecacheChannel("Punk")
		ix.musicRadio:PrecacheChannel("Alternative")
	end

	ix.musicRadio:AddAnnouncementsToClass("pirate", pirateAnnouncer)

	if (CLIENT) then
		ix.musicRadio:PrecacheAnnouncementsForClass("pirate")
	end

	--[[
		COMBINE RADIO STATIONS
	]]
	local classical = {
		[1] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_bach_cellosuite1gmaj.mp3", length = 140 },
		[2] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_chopin_balladeno1gminorop23.mp3", length = 537 },
		[3] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_chopin_nocturneop9no2.mp3", length = 256 },
		[4] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_chopin_nocturnno2.mp3", length = 244 },
		[5] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_kleine_serenadeno13gmaj.mp3", length = 383 },
		[6] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_kreisler_liebesleid.mp3", length = 201 },
		[7] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_mozart_concertono21cmaj.mp3", length = 444 },
		[8] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_satie_gymnopedie.mp3", length = 230 },
		[9] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_shostakovich_waltzno2.mp3", length = 242 },
		[10] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_tchaikovsky_waltzoftheflowers.mp3", length = 447 },
		[11] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_theswan.mp3", length = 172 },
		[11] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_rei_i.mp3", length = 176 },
		[12] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_vengerov_concerto.mp3", length = 205 },
		[13] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_tchaikovsky_lonelyhearts.mp3", length = 200 },
		[14] = { fname = "willardnetworks/musicradio/combine/classical/musicradio_tchaikovsky_adagio.mp3", length = 379 }
	}

	local jazz = {
		[1] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_chetbaker_autmnleaves.mp3", length = 413 },
		[2] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_chetbaker_ifallinlovetooeasily.mp3", length = 195 },
		[3] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_davebrubeck_takefive.mp3", length = 316 },
		[4] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_ellafitzgerald_summertime.mp3", length = 293 },
		[5] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_johncoltrane_giantsteps.mp3", length = 282 },
		[6] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_johncoltrane_myfavoritethings.mp3", length = 817 },
		[7] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_johncoltrane_mylittlebrownbook.mp3", length = 310 },
		[8] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_milesdavis_sowhat.mp3", length = 540 },
		[9] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_sinatra_way_you_look_tonight.mp3", length = 199 },
		[10] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_pepper_four_brothers.mp3", length = 177 },
		[11] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_milesdavis_blue_in_green.mp3", length = 330 },
		[12] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_louis_armstrong_wonderful_world.mp3", length = 134 },
		[13] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_stangetz_corcovado.mp3", length = 251 },
		[14] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_chetbaker_almostblue.mp3", length = 293 },
		[15] = { fname = "willardnetworks/musicradio/combine/jazz/musicradio_cohen_raincoat.mp3", length = 306 }
	}

	local funk = {
		[1] = { fname = "willardnetworks/musicradio/combine/funk/anri_shyness.mp3", length = 188 },
		[2] = { fname = "willardnetworks/musicradio/combine/funk/aran_im_in_love.mp3", length = 284 },
		[3] = { fname = "willardnetworks/musicradio/combine/funk/mamiya_japaneese.mp3", length = 234 },
		[4] = { fname = "willardnetworks/musicradio/combine/funk/matsubara_stay_with_me.mp3", length = 307 },
		[5] = { fname = "willardnetworks/musicradio/combine/funk/ohashi_i_love_you_so.mp3", length = 273 },
		[6] = { fname = "willardnetworks/musicradio/combine/funk/ohashi_sweet_love.mp3", length = 263 },
		[7] = { fname = "willardnetworks/musicradio/combine/funk/ohashi_telephone_number.mp3", length = 230 },
		[8] = { fname = "willardnetworks/musicradio/combine/funk/rick_james_give_it_to_me.mp3", length = 237 },
		[9] = { fname = "willardnetworks/musicradio/combine/funk/takeuichi_plastic_love.mp3", length = 269 },
		[10] = { fname = "willardnetworks/musicradio/combine/funk/yagami_bay_city.mp3", length = 237 },
		[11] = { fname = "willardnetworks/musicradio/combine/funk/yasuha_flyday_chinatown.mp3", length = 203 },
		[12] = { fname = "willardnetworks/musicradio/combine/funk/takahashi_sunset_road.mp3", length = 249 },
	}

	local speech = {
		[1] = { fname = "willardnetworks/musicradio/combine/speech/musicradio_breen_instinct.mp3", length = 191 },
		[2] = { fname = "willardnetworks/musicradio/combine/speech/musicradio_breen_civilprotection.mp3", length = 158 },
		[3] = { fname = "willardnetworks/musicradio/combine/speech/musicradio_breen_accomplishment.mp3", length = 156 },
		[4] = { fname = "willardnetworks/musicradio/combine/speech/musicradio_breen_civilprotection2.mp3", length = 173 },
		[5] = { fname = "willardnetworks/musicradio/combine/speech/musicradio_breen_progress.mp3", length = 208 },
		[6] = { fname = "willardnetworks/musicradio/combine/speech/musicradio_breen_support.mp3", length = 186 },
		[7] = { fname = "willardnetworks/musicradio/combine/speech/musicradio_breen_workshifts.mp3", length = 162 },
		[8] = { fname = "willardnetworks/musicradio/combine/speech/musicradio_breen_workshifts2.mp3", length = 167 }
	}

	local benefactorAnnouncer = {
		[1] = { fname = "willardnetworks/musicradio/combine/announcer/musicradio_benefactor_announce_1.mp3", length = 65 },
		[2] = { fname = "willardnetworks/musicradio/combine/announcer/musicradio_benefactor_announce_2.mp3", length = 65 }
	}

	-- Benefactor (cmb) radio stations:
	ix.musicRadio:AddChannel("Classical", classical, "benefactor", {
		dispX = 195,
		freq = 550
	})

	ix.musicRadio:AddChannel("Jazz", jazz, "benefactor", {
		dispX = 245,
		freq = 600
	})

	ix.musicRadio:AddChannel("Funk", funk, "benefactor", {
		dispX = 295,
		freq = 650
	})

	ix.musicRadio:AddChannel("Speech", speech, "benefactor", {
		dispX = 345,
		freq = 700
	})

	if (CLIENT) then
		ix.musicRadio:PrecacheChannel("Classical")
		ix.musicRadio:PrecacheChannel("Jazz")
		ix.musicRadio:PrecacheChannel("Funk")
		ix.musicRadio:PrecacheChannel("Speech")
	end

	--[[ Not adding right now because the MoE is dragging me through the mud on this
	ix.musicRadio:AddAnnouncementsToClass("benefactor", benefactorAnnouncer)

	if (CLIENT) then
		ix.musicRadio:PrecacheAnnouncementsForClass("benefactor")
	end
	]]

	--[[
		misc precaching
	]]
	for i=1, 6 do
		util.PrecacheSound("willardnetworks/musicradio/musicradio_static_"..tostring(i)..".mp3")
	end

	for i=1, 4 do
		util.PrecacheSound("willardnetworks/musicradio/musicradio_click_"..tostring(i)..".mp3")
	end
end

if (CLIENT) then
	local color = Color(75, 196, 0)
	function PLUGIN:InitializedPlugins()
		local function drawRadioESP(client, entity, x, y, factor)
			local txt = "Music Radio - ".."Chan: "..tostring(entity:GetChan()).." Vol ("..tostring(entity:GetVolume())..")".." On: "..tostring(entity:IsPlayingMusic())
			ix.util.DrawText(txt, x, y - math.max(10, 32 * factor), color,
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, math.max(255 * factor, 80))
		end

		ix.observer:RegisterESPType("wn_musicradio", drawRadioESP, "Music Radio")
	end
end
