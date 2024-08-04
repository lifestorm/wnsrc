--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


--
-- The client needs this file
--
AddCSLuaFile()

if ( !coroutine ) then return end

--
-- Name: coroutine.wait
-- Desc: Yield's the coroutine for so many seconds before returning.\n\nThis should only be called in a coroutine. This function uses CurTime() - not RealTime().
-- Arg1: number|seconds|The number of seconds to wait
-- Ret1: 
--
function coroutine.wait( seconds )

	local endtime = CurTime() + seconds
	while ( true ) do

		if ( endtime < CurTime() ) then return end

		coroutine.yield()

	end
	  
end
