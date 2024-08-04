--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Shared localization panel/hooks
local cameraActive = false
local combineOverlay = false
local cameraNumber = 1

local ButtonColor = Color(248, 248, 255)
local BackgroundColor = Color(0, 0, 0, 250)

local cameraLock = false

local cameras = {}
local cameraCount = #cameras

local PLUGIN = PLUGIN

surface.CreateFont( "CameraFont", {
	font = "DebugFixed",
	size = SScaleMin(50 / 3),
	weight = 50,
	blursize = 0,
	scanlines = 50,

} )

-- Console Panel
local PANEL = {}

function PANEL:Init()
	self:SetSize(SScaleMin(400 / 3), SScaleMin(300 / 3))
	self:Center()
	self:MakePopup()

	Schema:AllowMessage(self)

	self.Paint = function(_, w, h)
		draw.RoundedBox( 8, 0, 0, w, h, BackgroundColor )
	end

	self.topPanel = self:Add("Panel")
	self.topPanel:Dock(TOP)
	self.topPanel:SetTall(SScaleMin(20 / 3))
	self.topPanel:DockMargin(SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))

	local line = self:Add("DShape")
	line:SetType("Rect")
	line:Dock(TOP)
	line:SetTall(1)
	line:SetColor(color_white)
	line:DockMargin(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), SScaleMin(10 / 3))

	self:GetAllCameras()
	self:CreateCloseButton()
	self:CreateTitle()
	self:CreateButtons()
end

function PANEL:CreateCloseButton()
	local close = self.topPanel:Add("DButton")
	close:Dock(RIGHT)
	close:SetWide(SScaleMin(20 / 3))
	close:SetText("")
	close.Paint = function(_, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/tabmenu/navicons/exit-grey.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	close.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:TurnOff()
		self:Remove()
	end
end

function PANEL:CreateTitle()
	local combineText = self.topPanel:Add("DLabel")
	combineText:Dock(LEFT)
	combineText:SetFont("DebugFixedRadio")
	combineText:SetText(">:: ")
	combineText:SetContentAlignment(4)
	combineText:SizeToContents()

	self.title = self.topPanel:Add("DLabel")
	self.title:Dock(LEFT)
	self.title:SetFont("DebugFixedRadio")
	self.title:SetText("COMMAND CONSOLE")
	self.title:SetContentAlignment(4)
	self.title:SizeToContents()
end

function PANEL:CreateButtons()
	netstream.Start("GetLinkedUpdate")
	self.buttonlist = {}

	self.buttongrid = self:Add("DGrid")
	self.buttongrid:Dock(FILL)
	self.buttongrid:DockMargin(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), 0)
	self.buttongrid:SetCols(1)
	self.buttongrid:SetColWide(self:GetWide() - SScaleMin(20 / 3))
	self.buttongrid:SetRowHeight( SScaleMin(50 / 3) )

	local function CreateButton(parent, text, bAddToButtonList)
		parent:SetText(string.utf8upper(text))
		parent:SetSize(self:GetWide() - SScaleMin(20 / 3), SScaleMin(40 / 3))
		parent:SetTextColor(color_black)
		parent:SetFont("DebugFixedRadio")
		parent.Paint = function(_, w, h)
			draw.RoundedBox( 8, 0, 0, w, h, ButtonColor )
		end

		if bAddToButtonList then
			self.buttongrid:AddItem(parent)
			self:AddToButtonList(parent)
		end
	end

	self.thirdperson = false

	local cameraButton = vgui.Create("DButton")
	CreateButton(cameraButton, "cameras", true)
	cameraButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if cameraCount >= 1 then
			cameraActive = true
			combineOverlay = true
			if ix.option.Get("thirdpersonEnabled") then
				self.thirdperson = true
				ix.option.Set("thirdpersonEnabled", false)
			end

			self:SetVisible(false)
			self:CreateCameraUI()
			self:AddPVS()
		end
	end

	local character = LocalPlayer():GetCharacter()
	local class = character:GetClass()
	if (class == CLASS_CP_CMD or class == CLASS_CP_CPT or class == CLASS_CP_RL or class == CLASS_OVERSEER or class == CLASS_OW_SCANNER) then
		netstream.Start("GetConsoleUpdates", self.entity)

		local addLink = vgui.Create("DButton")
		CreateButton(addLink, "link update", true)
		addLink.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			local chooseUpdatePanel = vgui.Create("DFrame")
			chooseUpdatePanel:SetSize(SScaleMin(300 / 3), SScaleMin(500 / 3))
			chooseUpdatePanel:Center()
			chooseUpdatePanel:SetTitle("Wybierz aktualizację")
			DFrameFixer(chooseUpdatePanel)

			local scrollPanel = chooseUpdatePanel:Add("DScrollPanel")
			scrollPanel:Dock(FILL)

			for _, v in pairs(self.updates) do
				local button = scrollPanel:Add("DButton")
				button:Dock(TOP)
				button:SetTall(SScaleMin(50 / 3))
				button:SetFont("DebugFixedRadio")
				button:SetText(string.utf8sub( v.update_text, 1, 20 ).."... - "..v.update_poster)
				button.Paint = function(_, w, h)
					surface.SetDrawColor(Color(0, 0, 0, 100))
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
					surface.DrawOutlinedRect(0, 0, w, h)
				end
				button.DoClick = function()
					surface.PlaySound("helix/ui/press.wav")
					netstream.Start("SetLinkedUpdate", self.entity, v.update_text)
					chooseUpdatePanel:Remove()
				end
			end
		end
	end

	local updates = vgui.Create("DButton")
	CreateButton(updates, "updates", true)
	updates.DoClick = function()
		if !ix.data.Get("CameraConsoleLinkedUpdate") then
			LocalPlayer():NotifyLocalized("Brak powiązanej aktualizacji")
			return
		end

		local updatePanel = vgui.Create("DFrame")
		updatePanel:SetSize(SScaleMin(600 / 3), SScaleMin(700 / 3))
		updatePanel:Center()
		updatePanel:MakePopup()
		Schema:AllowMessage(updatePanel)
		
		updatePanel:SetTitle("Update")
		DFrameFixer(updatePanel)
		updatePanel.lblTitle:SetFont("MenuFontNoClamp")
		updatePanel.lblTitle:SizeToContents()

		local htmlPanel = updatePanel:Add("HTML")
		htmlPanel:Dock(FILL)
		local string = "<p style='font-family: Open Sans; font-size: "..tostring(SScaleMin(13 / 3)).."; color: rgb(41,243,229);'>"..tostring(ix.data.Get("CameraConsoleLinkedUpdate")).."</p>"
		if istable(ix.data.Get("CameraConsoleLinkedUpdate")) then
			if table.IsEmpty(ix.data.Get("CameraConsoleLinkedUpdate")) then
				string = "<p style='font-family: Open Sans; font-size: "..tostring(SScaleMin(13 / 3)).."; color: rgb(41,243,229);'>Brak aktualizacji.</p>"
			end
		end

		local html = string.Replace(string, "\n", "<br>")
		htmlPanel:SetHTML(html)
		htmlPanel.Paint = function(_, w, h)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)
		end
	end
end

netstream.Hook("ReplyCrimeReports", function(crimes)
	if ix.gui.datapadCrimes and IsValid(ix.gui.datapadCrimes) then
		ix.gui.datapadCrimes:CreateCrimes(crimes)
	end
end)

function PANEL:CreateCameraUI()
	local cameraPanel = vgui.Create( "Panel" )
	cameraPanel:SetPos( ScrW() / 2 + SScaleMin(350 / 3), ScrH() / 2 + SScaleMin(280 / 3))
	cameraPanel:SetSize( SScaleMin(200 / 3), SScaleMin(100 / 3) )
	cameraPanel:MakePopup()
	Schema:AllowMessage(cameraPanel)

	local CameraUI3 = vgui.Create( "Panel", cameraPanel )
	CameraUI3:SetPos( ScrW() / 2 + SScaleMin(350 / 3), ScrH() / 2 + SScaleMin(110 / 3))
	CameraUI3:SetSize( SScaleMin(200 / 3), SScaleMin(150 / 3) )

	local back = cameraPanel:Add("DButton")
	back:Dock(TOP)
	back:SetTextColor(color_black)
	back:SetTall(SScaleMin(20 / 3))
	back:SetFont("DebugFixedRadio")
	back:SetText("Powrót")
	back.Paint = function(_, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/tabmenu/navicons/exit-grey.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	back.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:CameraOff()
		cameraPanel:Remove()
		self:SetVisible(true)
		if self.thirdperson then
			ix.option.Set("thirdpersonEnabled", true)
		end
	end

	local nextCamera = vgui.Create( "DButton", cameraPanel )
	nextCamera:SetText( "Następne" )
	nextCamera:SetFont("DebugFixedRadio")
	nextCamera:SetTextColor( Color(0, 0, 0, 255) )
	nextCamera:SetPos( SScaleMin(105 / 3), SScaleMin(30 / 3) )
	nextCamera:SetSize( SScaleMin(75 / 3), SScaleMin(25 / 3) )
	nextCamera.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if cameraNumber < cameraCount then
			cameraNumber = cameraNumber + 1
			self:AddPVS()
		end
	end

	local previousCamera = vgui.Create( "DButton", cameraPanel )
	previousCamera:SetText( "Poprzednie" )
	previousCamera:SetFont("DebugFixedRadio")
	previousCamera:SetTextColor( Color(0, 0, 0, 255) )
	previousCamera:SetPos( SScaleMin(20 / 3), SScaleMin(30 / 3) )
	previousCamera:SetSize( SScaleMin(75 / 3), SScaleMin(25 / 3) )
	previousCamera.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if cameraNumber > 1 then
			cameraNumber = cameraNumber - 1
			self:AddPVS()
		end
	end

	local LockCamera = vgui.Create( "DButton", cameraPanel )
		LockCamera:SetText( "Zablokuj" )
		LockCamera:SetFont("DebugFixedRadio")
		LockCamera:SetTextColor( Color(0, 0, 0, 255) )
		LockCamera:SetPos( SScaleMin(20 / 3), SScaleMin(60 / 3) )
		LockCamera:SetSize( SScaleMin(75 / 3), SScaleMin(25 / 3) )
		LockCamera.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			cameraLock = !cameraLock
		end

	local List = vgui.Create( "DPanelList", CameraUI3 )
	List:SetSize(SScaleMin(190 / 3), SScaleMin(120 / 3))
	List:SetSpacing( SScaleMin(5 / 3) )
	List:SetPos(SScaleMin(5 / 3), SScaleMin(15 / 3))
	List:EnableHorizontal( false )
	List:EnableVerticalScrollbar( true )
	for k, _ in pairs(cameras) do
		local Spawnd = vgui.Create("DButton", List)
		Spawnd:SetText("Kamera "..k)
		Spawnd:SetFont("DebugFixedRadio")
		Spawnd:SetTextColor( Color(0, 0, 0, 255) )
		Spawnd:SetSize( SScaleMin(75 / 3), SScaleMin(25 / 3) )
		Spawnd.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			cameraNumber = k
			self:AddPVS()
		end
		Spawnd.Paint = function()
			draw.RoundedBox( 8, 0, 0, Spawnd:GetWide(), Spawnd:GetTall(), ButtonColor )
		end
		List:AddItem( Spawnd )
	end

	local Elements = { cameraPanel; CameraUI3; back; nextCamera; previousCamera; LockCamera}
	for k,v in pairs(Elements) do
		if k > 2 then
			v.Paint = function()
				draw.RoundedBox( 8, 0, 0, v:GetWide(), v:GetTall(), ButtonColor )
			end
		else
			v.Paint = function()
				draw.RoundedBox( 8, 0, 0, v:GetWide(), v:GetTall(), BackgroundColor )
			end
		end
	end
end

function PANEL:AddToButtonList(button)
	if button then
		if self.buttonlist then
			if istable(self.buttonlist) then
				table.insert(self.buttonlist, button)
			end
		end
	end
end

function PANEL:CameraOff()
	cameraActive = false
	combineOverlay = false
	cameraNumber = 1
	cameraLock = false
end

function PANEL:TurnOff()
	netstream.Start("CloseConsole", self.entity)
end

function PANEL:AddPVS()
	netstream.Start("SetConsoleCameraPos", self.entity, cameras[cameraNumber])
end

function PANEL:GetAllCameras()
	if !table.IsEmpty(cameras) then
		table.Empty(cameras)
	end

	for _, v in pairs(ents.GetAll()) do
		if (v:GetClass() == "npc_combine_camera" or v:GetClass() == "npc_turret_ceiling") then
			table.insert(cameras, v)
		end
	end
	cameraCount = #cameras
end


vgui.Register("ConsolePanel", PANEL, "Panel")

-- Hooks
local function DrawCombineOverlay()
	if combineOverlay then
		DrawMaterialOverlay( "effects/combine_binocoverlay.vmt", 0.1 )

		surface.SetTextColor( 255, 0, 0, 255 )
		surface.SetTextPos( SScaleMin(100 / 3), SScaleMin(75 / 3) )
		surface.SetFont("CameraFont")
		surface.DrawText( "Kamera ".. cameraNumber )
	end
end

hook.Add( "RenderScreenspaceEffects", "ConsoleCameraOverlay", DrawCombineOverlay )

local function CalculateConsoleCameraView( client, pos, angles, fov )
	if cameraActive then
		if cameraCount >= 1 then
			if cameras[cameraNumber]:IsValid() then
				local BoneIndex = cameras[cameraNumber]:LookupAttachment("eyes")
				local Bone = cameras[cameraNumber]:GetAttachment( BoneIndex )

				local view = {}

				if cameraLock == false then
					view.origin = Bone.Pos + cameras[cameraNumber]:GetForward() * 6
					view.angles = Bone.Ang
					view.fov = fov
					view.vm_origin = LocalPlayer():GetForward() * -100
				else
					view.origin = cameras[cameraNumber]:GetPos() + cameras[cameraNumber]:GetUp() * -50 + cameras[cameraNumber]:GetForward() * 30
					view.angles = cameras[cameraNumber]:GetAngles() + Angle(10,0,0)
					view.fov = fov
					view.vm_origin = LocalPlayer():GetForward() * -100
				end

				return view
			end
		end
	end
end

hook.Add( "CalcView", "CalculateConsoleCameraView", CalculateConsoleCameraView )