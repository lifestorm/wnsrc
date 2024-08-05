--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Stealth"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Adds several stealth-related features."

ix.util.Include("meta/sv_entity.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_hooks.lua")

ix.chat.Register("mev", {
	format = "*** %s %s",
	color = Color(128, 128, 128, 255),
	CanHear = function(self, speaker, listener)
		if (speaker:GetEyeTraceNoCursor().Entity == listener or speaker == listener) then
			return true
		else
			local trace = {}
			
			trace.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_MONSTER
			trace.start = listener:LocalToWorld(listener:OBBCenter())
			trace.endpos = speaker:GetShootPos()
			trace.filter = {listener, speaker}
			
			trace = util.TraceLine(trace)
			
			if (trace.Fraction >= (0.75)) then
				return true
			end
		end

		return false
	end,
	prefix = {"/MeV"},
	description = "@cmdMev",
	indicator = "chatPerforming"
})

ix.chat.Register("sv", {
	format = "*** %s motions \"%s\"",
	color = Color(128, 128, 128, 255),
	CanHear = function(self, speaker, listener)
		if (speaker:GetEyeTraceNoCursor().Entity == listener or speaker == listener) then
			return true
		else
			local trace = {}
			
			trace.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_MONSTER
			trace.start = listener:LocalToWorld(listener:OBBCenter())
			trace.endpos = speaker:GetShootPos()
			trace.filter = {listener, speaker}
			
			trace = util.TraceLine(trace)
			
			if (trace.Fraction >= (0.75)) then
				return true
			end
		end

		return false
	end,
	prefix = {"/SV"},
	description = "@cmdSV",
	indicator = "chatPerforming"
})
