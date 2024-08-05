--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

surface.CreateFont( "arcade_font20", {
	font = "Calibri",
	size = 20,
	weight = 100
})
surface.CreateFont( "arcade_font25", {
	font = "Calibri",
	size = 25,
	weight = 100
})
surface.CreateFont( "arcade_font30", {
	font = "Calibri",
	size = 30,
	weight = 100
})
surface.CreateFont( "arcade_font60", {
	font = "Calibri",
	size = 60,
	weight = 100
})
surface.CreateFont( "arcade_font80", {
	font = "Calibri",
	size = 80,
	weight = 100
})
surface.CreateFont( "arcade_font120", {
	font = "Calibri",
	size = 120,
	weight = 100
})

net.Receive("arcade_adjust_timer", function()
  local timers = {
    "PacMan_CloseTime",
    "PONG_CloseTime",
    "Space_CloseTime"
  }

  for k, v in pairs(timers) do
    if (timer.Exists(v)) then
      timer.Adjust(v, (ix.config.Get("arcadeTime")) + timer.TimeLeft(v), 1)
    end
  end
end)
