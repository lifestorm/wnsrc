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

local medialib = include("libs/cl_medialib.lua")

local volConVarName = "ix_lnsongplayer_volume"
PLUGIN.songVolume = CreateClientConVar(volConVarName, "50", true)

cvars.AddChangeCallback(volConVarName, function(cvarName, oldVal, newVal)
	if (IsValid(PLUGIN.mediaclip)) then
		PLUGIN.mediaclip:setVolume(newVal / 100)
	end
end)

function PLUGIN:FetchVideoInfo(id, callback)
	if (IsValid(medialib)) then
		medialib:stop()
	end

	if (IsValid(self.mediaclip)) then
		self.mediaclip:stop()
	end

	local service = medialib.load("media").guessService(id)

	if (service) then
		self.mediaclip = service:load(id)

		service:query(id, function(err, data)
			if (err) then
				return
			end

			callback(data, self.mediaclip)
		end)
	end
end

function PLUGIN:Play(id, offset)
	offset = offset or 0

	if (IsValid(self.ui.panel)) then
		self.ui.panel:Remove()
	end

	self.ui.panel = vgui.Create("ixSongPlayer")

	self.startTime = 0
	self.currentSongDuration = 0

	self.ui.panel:SetLoading(true)
	self.ui.panel:SetTitle("Loading song...")

	if (!self.ui.panel:IsVisible()) then
		self.ui.panel:FadeIn()
	end

	self:FetchVideoInfo(id, function(data, mediaclip)
		if (data) then
			self.currentTitle = data.title
			self.offsetTime = offset

			if (IsValid(self.ui.panel)) then
				local time = string.FormattedTime(data.duration)
				local title = string.format("%s [%s]", data.title or "unknown", string.format("%i:%i", time.m, time.s))

				self.ui.panel:SetTitle(title)
				self.ui.panel:SetLoading(false)
			end

			timer.Simple(data.duration, function()
				if (!IsValid(self.ui.panel)) then
					return
				end

				self.ui.panel:FadeOut()
			end)

			self.startTime = CurTime() - self.offsetTime
			self.currentSongDuration = data.duration

			mediaclip:play()
			mediaclip:seek(offset or 0)
			mediaclip:setVolume(self.songVolume:GetInt() / 100)
		end
	end)
end

net.Receive("lnSongPlayerPlay", function()
	local url = net.ReadString()
	local time = net.ReadFloat()

	PLUGIN:Play(url, time)
end)

net.Receive("lnSongPlayerStop", function()
	if (IsValid(PLUGIN.ui.panel)) then
		PLUGIN.ui.panel:FadeOut()
	end

	if (IsValid(PLUGIN.mediaclip)) then
		PLUGIN.mediaclip:stop()
	end
end)

function draw.Circle(x, y, radius, segments)
	local p = {}

	table.insert(p, {
		x = x,
		y = y,
		u = 0.5,
		v = 0.5
	})

	for i = 0, segments do
		local ang = math.rad((i/segments) * -360)
		table.insert(p, {
			x = x + math.sin(ang) * radius,
			y = y + math.cos(ang) * radius,
			u = math.sin(ang) / 2 + 0.5,
			v = math.cos(ang) / 2 + 0.5
		})
	end

	local ang = math.rad(0)

	table.insert(p, {
		x = x + math.sin(ang) * radius,
		y = y + math.cos(ang) * radius,
		u = math.sin(ang) / 2 + 0.5,
		v = math.cos(ang) / 2 + 0.5
	})

	surface.DrawPoly(p)
end
