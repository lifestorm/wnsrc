--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local domain = CreateConVar("xeon_dev", 0, bit.bor(FCVAR_REPLICATED, FCVAR_UNREGISTERED, FCVAR_UNLOGGED, FCVAR_DONTRECORD), nil, 0, 1):GetInt() == 1 and "http://gmod.local" or "https://xeon.network"

local XEON_AUTH
local XEON_IP
net.Receive("XEON.Auth", function(len)
	if net.ReadBool() then
		if not IsValid(XEON_AUTH) then return end

		local path = net.ReadString()

		XEON_AUTH:Remove()
		XEON_AUTH = Derma_Query(
			"You will now be prompted to open a URL in the Steam Overlay. Please click \"Yes\" when prompted.\n\nThe URL will redirect you to a Sign in through Steam page for https://xeon.network.\nYou won't need to enter a username or password, the Steam Overlay should already have you logged in.",
			"XEON DRM",
			"Continue", function()
				gui.OpenURL(domain .. path)
			end,
			"Cancel"
		)
	end

	net.Start("XEON.Auth")
	net.SendToServer()

	if IsValid(XEON_AUTH) then return end

	if not LocalPlayer():IsSuperAdmin() then
		XEON_AUTH = Derma_Message("Thanks for installing one of Billy's scripts!\nTo activate your license and use your new scripts, you need to be a superadmin. Please promote yourself to superadmin, then respawn or rejoin to try again.", "XEON DRM", "Dismiss")
		return
	end

	XEON_AUTH = Derma_Query(
		"Thanks for installing one of Billy's scripts!\nTo activate your license and use your new scripts, I'll need you to log in to Steam via the Steam Overlay to authenticate that this server belongs to you.\nWould you like to do this now?",
		"XEON DRM",
		"Link Server", function()
			XEON_AUTH = Derma_Message("Connecting to XEON... please wait. If nothing happens, please check your server's console.", "XEON DRM", "Cancel")

			if not IsValid(XEON_IP) then
				XEON_IP = vgui.Create("DHTML")

				if not IsValid(XEON_IP) or not XEON_IP.OpenURL then
					XEON_IP = { GetIPAddress = function(_, callback) callback(nil) end }
				else
					XEON_IP:SetSize(0, 0)
					XEON_IP:AddFunction("XEON", "IP", function(IP)
						timer.Remove("XEON_IP")
						XEON_IP.IP = IP
						for _, c in ipairs(XEON_IP.IP_Callbacks) do c(IP) end
						XEON_IP.IP_Callbacks = {}
					end)

					XEON_IP.IP_Callbacks = {}
					function XEON_IP:GetIPAddress(callback)
						if os.time() - self.StartedLoading > 5 then
							callback(nil)
						elseif self.IP then
							callback(self.IP)
						else
							table.insert(self.IP_Callbacks, callback)
						end
					end

					function XEON_IP:OnFinishLoadingDocument(IP)
						self:QueueJavascript("XEON.IP(document.body.textContent.trim())")
					end

					XEON_IP.StartedLoading = os.time()
					XEON_IP:OpenURL("https://icanhazip.com/")

					timer.Create("XEON_IP", 1, 0, function()
						if not IsValid(XEON_IP) then
							timer.Remove("XEON_IP")
							return
						end

						if os.time() - XEON_IP.StartedLoading <= 5 then return end

						timer.Remove("XEON_IP")

						for _, c in ipairs(XEON_IP.IP_Callbacks) do c(nil) end
						XEON_IP.IP_Callbacks = {}
					end)
				end
			end

			XEON_IP:GetIPAddress(function(IP)
				net.Start("XEON.Auth")
					net.WriteBool(true)
					net.WriteString(tostring(IP or ""))
				net.SendToServer()
			end)
		end,
		"Dismiss"
	)
end)

local function openErrors(errors)
	if IsValid(XEON_ERRORS) then
		XEON_ERRORS:Update(errors)
		return
	end

	XEON_ERRORS = vgui.Create("DFrame")
	XEON_ERRORS:SetSize(ScrW() * .8, ScrH() * .8)
	XEON_ERRORS:SetTitle("XEON DRM by Billy - Error!")
	XEON_ERRORS:Center()
	XEON_ERRORS:MakePopup()

	local html = vgui.Create("DHTML", XEON_ERRORS)
	html:Dock(FILL)
	html:OpenURL(domain .. "/errors")
	html:AddFunction("XEON", "ScriptSupport", function()
		gui.OpenURL("https://support.billy.enterprises")
	end)

	function XEON_ERRORS:Update(errors)
		print("XEON Errors: " .. #errors)
		PrintTable(errors)

		html:QueueJavascript("ShowNetworkedErrors(" .. util.TableToJSON(errors) .. ")")
	end
	function html:OnDocumentReady()
		XEON_ERRORS:Update(errors)
		self.OnDocumentReady = nil
	end
	XEON_ERRORS:Update(errors)

	sound.PlayURL("https://xeon.network/static/media/oof.mp3", "", function() end)
end

net.Receive("XEON.Error", function()
	local errors = {}
	for i = 1, net.ReadUInt(16) do
		errors[i] = net.ReadString()
	end
	openErrors(errors)
end)

hook.Add("InitPostEntity", "XEON.Error", function()
	timer.Simple(2, function()
		net.Start("XEON.Error")
		net.SendToServer()
	end)
end)