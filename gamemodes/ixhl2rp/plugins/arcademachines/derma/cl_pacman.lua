--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

net.Receive("arcade_request_pacman", function()

	local frame = vgui.Create("DFrame")
	frame:SetSize(300, 125)
	frame:Center()
	frame:MakePopup()
	frame:SetDraggable(false)
	frame:SetTitle("")
	frame:ShowCloseButton(false)
	frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(frame, 4)
		draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,100))
		draw.RoundedBox(0, 0, 0, w, 15, Color(25,25,25,255))
		draw.SimpleText("Play PACMAN for "..ix.config.Get("arcadePrice").." Credit?", "arcade_font30", w/2, h/4, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local accept = vgui.Create("DButton", frame)
	accept:SetPos(5, 50)
	accept:SetSize(140,70)
	accept:SetText("")
	accept.DoClick = function()
		frame:Close()
		net.Start("arcade_accept_pacman")
		net.SendToServer()
	end
	accept.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(0,100,0))
		draw.SimpleText("Insert Credit", "arcade_font30", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local deny = vgui.Create("DButton", frame)
	deny:SetPos(155, 50)
	deny:SetSize(140,70)
	deny:SetText("")
	deny.DoClick = function()
		frame:Close()
	end
	deny.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(100,0,0))
		draw.SimpleText("Nevermind", "arcade_font30", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

end)


net.Receive("arcade_open_pacman", function()

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrH()*0.95, ScrH()*0.95+25)
	frame:Center()
	frame:MakePopup()
	frame:SetDraggable(false)
	frame:SetTitle("")
	frame:ShowCloseButton(false)
	if !ix.config.Get("arcadeDisableTokenSystem") then
		timer.Create("PacMan_CloseTime", (ix.config.Get("arcadeTime")*ix.config.Get("arcadePrice")), 1, function() frame:Close() end)
	end
	frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(frame, 4)
		draw.RoundedBox(0, 0, 0, w, 50, Color(0,0,0,100))
		draw.RoundedBox(0, 0, 0, w, 15, Color(25,25,25,255))

--		draw.RoundedBox(0, 0, 0, w, 65, Color(200,200,200))


		if !ix.config.Get("arcadeDisableTokenSystem") then
			local timeleft = string.FormattedTime(timer.TimeLeft("PacMan_CloseTime"))
			local extranum
			if timeleft.s < 10 then
				extranum = 0
			else
				extranum = ""
			end
			draw.SimpleText("Time Left: "..timeleft.m..":"..extranum..timeleft.s, "arcade_font30", 5, 17, Color(255,255,255))
		end
	end

	Schema:AllowMessage(frame)

	local close = vgui.Create("DButton", frame)
	close:SetPos(frame:GetWide()-50, 20)
	close:SetSize(50,25)
	close:SetText("Close")
	close.DoClick = function()
		frame:Close()
		timer.Remove("PacMan_CloseTime")
	end
	close.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(200,0,0))
	end

	if !ix.config.Get("arcadeDisableTokenSystem") then
		local moretime = vgui.Create("DButton", frame)
		moretime:SetPos(frame:GetWide()-200, 20)
		moretime:SetSize(150,25)
		moretime:SetText("Insert another coin?")
		moretime.DoClick = function()
			net.Start("arcade_moretime_credit")
			net.SendToServer()
		end
		moretime.Paint = function(self, w, h)
			draw.RoundedBox(0,0,0,w,h,Color(0,155,155))
		end
	end

	local webshell = vgui.Create("DPanel", frame)
	webshell:SetSize(frame:GetWide(), frame:GetTall()-60)
	webshell:SetPos(0,60)

	local web = vgui.Create("HTML", webshell)
	web:Dock( FILL )
	web:OpenURL(ix.config.Get("arcadePacManWebsite"))
end)
