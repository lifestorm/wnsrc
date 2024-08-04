--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

DEFINE_BASECLASS("tfa_gun_base")
SWEP.Skins = {}
SWEP.Skin = ""
SWEP.Callback = {}
SWEP.VMPos = Vector(0.879, 0.804, -1)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.ProceduralHolsterEnabled = true
SWEP.ProceduralHolsterTime = 0.0
SWEP.ProceduralHolsterPos = Vector(0, 0, 0)
SWEP.ProceduralHolsterAng = Vector(0, 0, 0)
SWEP.NoStattrak = false
SWEP.NoNametag = false
SWEP.TracerCount = 1
SWEP.TracerName = "tfa_tracer_csgo" -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerDelay		= 0.0 --Delay for lua tracer effect
SWEP.IsTFACSGOWeapon = true

--These are particle effects INSIDE a pcf file, not PCF files, that are played when you shoot.
SWEP.SmokeParticles = {
	pistol = "weapon_muzzle_smoke",
	smg = "weapon_muzzle_smoke",
	grenade = "weapon_muzzle_smoke",
	ar2 = "weapon_muzzle_smoke_long",
	shotgun = "weapon_muzzle_smoke_long",
	rpg = "weapon_muzzle_smoke",
	physgun = "weapon_muzzle_smoke",
	crossbow = "weapon_muzzle_smoke",
	melee = "weapon_muzzle_smoke",
	slam = "weapon_muzzle_smoke",
	normal = "weapon_muzzle_smoke",
	melee2 = "weapon_muzzle_smoke",
	knife = "weapon_muzzle_smoke",
	duel = "weapon_muzzle_smoke",
	camera = "weapon_muzzle_smoke",
	magic = "weapon_muzzle_smoke",
	revolver = "weapon_muzzle_smoke",
	silenced = "weapon_muzzle_smoke"
}

TFA = TFA or {}
TFA.CSGO = TFA.CSGO or {}
TFA.CSGO.Skins = TFA.CSGO.Skins or {}

function SWEP:Initialize()
	BaseClass.Initialize(self)

	self:ReadSkin()

	if SERVER then
		self:CallOnClient("ReadSkin", "")
	end
end

local bgcolor = Color(0, 0, 0, 255 * 0.78)
local btntextcol = Color(191, 191, 191, 255 * 0.9)
local btntextdisabledcol = Color(63, 63, 63, 255 * 0.9)

local emptyFunc = function() end

local SkinMenuFrame

local sp = game.SinglePlayer()

function SWEP:AltAttack()
	if sp and SERVER then self:CallOnClient("AltAttack") return end

	if not CLIENT or IsValid(SkinMenuFrame) then return end

	SkinMenuFrame = vgui.Create("DFrame")

	SkinMenuFrame:SetSkin("Default")

	SkinMenuFrame:SetSize(320, 24 + 64 * 3 + 5 * 4)
	SkinMenuFrame:Center()

	SkinMenuFrame:ShowCloseButton(false)
	SkinMenuFrame:SetDraggable(false)

	SkinMenuFrame:SetTitle("TFA CS:GO Weapon Actions")
	SkinMenuFrame:MakePopup()

	SkinMenuFrame.Paint = function(myself, wv, hv)
		local x, y = myself:GetPos()

		render.SetScissorRect(x, y, x + wv, y + hv, true)
		Derma_DrawBackgroundBlur(myself)
		render.SetScissorRect(0, 0, 0, 0, false)

		draw.NoTexture()
		surface.SetDrawColor(bgcolor)
		surface.DrawRect(0, 0, wv, hv)
	end

	local btnSkinPicker = vgui.Create("DButton", SkinMenuFrame)
	btnSkinPicker:SetTall(64)
	btnSkinPicker:DockMargin(0, 0, 0, 5)
	btnSkinPicker:Dock(TOP)

	btnSkinPicker:SetFont("DermaLarge")
	btnSkinPicker:SetTextColor(btntextcol)
	btnSkinPicker.Paint = emptyFunc

	btnSkinPicker:SetText("Change Skin")

	btnSkinPicker.DoClick = function(btn, value)
		RunConsoleCommand("cl_tfa_csgo_vgui_skinpicker")

		SkinMenuFrame:Close()
	end

	local btnNamePicker = vgui.Create("DButton", SkinMenuFrame)
	btnNamePicker:SetTall(64)
	btnNamePicker:DockMargin(0, 0, 0, 5)
	btnNamePicker:Dock(TOP)

	btnNamePicker:SetFont("DermaLarge")
	btnNamePicker:SetTextColor(btntextcol)
	btnNamePicker.Paint = emptyFunc

	btnNamePicker:SetText("Change Nametag")

	if self.NoNametag then
		btnNamePicker:SetDisabled(true)
		btnNamePicker:SetTextColor(btntextdisabledcol)
		btnNamePicker:SetCursor("no")
	end

	btnNamePicker.DoClick = function(btn, value)
		RunConsoleCommand("cl_tfa_csgo_vgui_namepicker")

		SkinMenuFrame:Close()
	end

	local btnClose = vgui.Create("DButton", SkinMenuFrame)
	btnClose:SetTall(64)
	btnClose:DockMargin(0, 0, 0, 0)
	btnClose:Dock(BOTTOM)

	btnClose:SetFont("DermaLarge")
	btnClose:SetTextColor(btntextcol)
	btnClose.Paint = emptyFunc

	btnClose:SetText("Close")

	btnClose.DoClick = function(btn, value)
		SkinMenuFrame:Close()
	end
end

function SWEP:SaveSkin()
	if CLIENT then
		if not file.Exists("tfa_csgo/", "DATA") then
			file.CreateDir("tfa_csgo")
		end

		local f = file.Open("tfa_csgo/" .. self:GetClass() .. ".txt", "w", "DATA")
		f:Write(self.Skin and self.Skin or "")
		f:Flush()
	end
end

function SWEP:SyncToServerSkin(skin)
	if not skin or string.len(skin) <= 0 then
		skin = self.Skin
	end

	if not skin then return end
	if not CLIENT then return end
	-- net.Start("TFA_CSGO_SKIN", true)
	-- net.WriteEntity(self)
	-- net.WriteString(skin)
	-- net.SendToServer()
end

function SWEP:LoadSkinTable()
	if true then return end
	local cl = self:GetClass()

	if TFA.CSGO.Skins[cl] then
		for k, v in pairs(TFA.CSGO.Skins[cl]) do
			self.Skins[k] = v
		end
	end
end

function SWEP:ReadSkin()
	if CLIENT then
		self:LoadSkinTable()
		local cl = self:GetClass()
		local path = "tfa_csgo/" .. cl .. ".txt"

		if file.Exists(path, "DATA") then
			local f = file.Read(path, "DATA")

			if f and v ~= "" then
				self.Skin = f
			end
		end

		self:SetNWString("skin", self.Skin)
		self:SyncToServerSkin()
	end

	self:UpdateSkin()
end

function SWEP:UpdateSkin()
	if (CLIENT and IsValid(LocalPlayer()) and LocalPlayer() ~= self.Owner) or SERVER then
		self:SetMaterial("")
		self.Skin = self:GetNWString("skin")

		if self.Skins and self.Skins[self.Skin] and self.Skins[self.Skin].tbl then
			self:SetSubMaterial(nil, nil)

			for k, str in ipairs(self.Skins[self.Skin].tbl) do
				if type(str) == "string" then
					self:SetSubMaterial(k - 1, str)

					return
				end
			end
			self:ClearMaterialCache()
		end
	end

	if not self.Skin then
		self.Skin = ""
	end

	if self.Skin and self.Skins and self.Skins[self.Skin] then
		self.MaterialTable = self.Skins[self.Skin].tbl

		for l, b in pairs(self.MaterialTable) do
			TFA.CSGO.LoadCachedVMT(string.sub(b, 2))
			print("Requesting skin #" .. l .. "//" .. string.sub(b, 2))
		end
		self:ClearMaterialCache()
	end
end

SWEP.LerpLight = Vector(1, 1, 1)

SWEP.VElements = {
	["nametag"] = { type = "Model", model = "models/weapons/tfa_csgo/uid.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, bodygroup = {}, active = true },
	["stattrak"] = { type = "Model", model = "models/weapons/tfa_csgo/stattrack.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, bodygroup = {}, active = true },
}

local stattrak_cv = GetConVar("cl_tfa_csgo_stattrack") or CreateClientConVar("cl_tfa_csgo_stattrack", 1, true, true)
local dostattrak

function SWEP:UpdateStattrak()
	if not CLIENT or not self.VElements["stattrak"] then return end

	dostattrak = stattrak_cv:GetBool() and not self.NoStattrak

	local statname = "VElements.stattrak.active"

	if self:GetStat(statname) ~= dostattrak then
		self.VElements["stattrak"].active = dostattrak
		self:ClearStatCache(statname)
	end
end

local nametag_cv = GetConVar("cl_tfa_csgo_nametag") or CreateClientConVar("cl_tfa_csgo_nametag", 1, true, true)
local donametag

function SWEP:UpdateNametag()
	if not CLIENT or not self.VElements["nametag"] then return end

	donametag = nametag_cv:GetBool() and not self.NoNametag

	local statname = "VElements.nametag.active"

	if self:GetStat(statname) ~= donametag then
		self.VElements["nametag"].active = donametag
		self:ClearStatCache(statname)
	end
end

local shells_cv = GetConVar("cl_tfa_csgo_2dshells") or CreateClientConVar("cl_tfa_csgo_2dshells", 1, true, true)

local shellsoverride
function SWEP:UpdateShells()
	if SERVER then
		shellsoverride = (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and self:GetOwner():GetInfoNum(shells_cv:GetName(), 0) > 0) and "tfa_shell_csgo" or nil
	else
		shellsoverride = shells_cv:GetBool() and "tfa_shell_csgo" or nil
	end

	local statname = "ShellEffectOverride"

	if self:GetStat(statname) ~= shellsoverride then
		self.ShellEffectOverride = shellsoverride
		self:ClearStatCache(statname)
	end
end

function SWEP:MakeShell(...)
	self:UpdateShells()

	return BaseClass.MakeShell(self, ...)
end

function SWEP:Think2(...)
	if ((CLIENT and IsValid(LocalPlayer()) and LocalPlayer() ~= self.Owner) or SERVER) and self.Skin ~= self:GetNWString("skin") then
		self.Skin = self:GetNWString("skin")
		self:UpdateSkin()
	end

	self:UpdateStattrak()
	self:UpdateNametag()

	BaseClass.Think2(self, ...)
end

function SWEP:SetBodyGroupVM(k, v)
	if isstring(k) then
		local vals = k:Split(" ")
		k = vals[1]
		v = vals[2]
	end

	self.Bodygroups_V[k] = v

	if SERVER then
		self:CallOnClient("SetBodyGroupVM", "" .. k .. " " .. v)
	end
end

local cv_chamber = GetConVar("sv_tfa_csgo_chambering") or CreateConVar("sv_tfa_csgo_chambering", 1, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Allow round-in-the-chamber on TFA CS:GO weapons?")

function SWEP:CanChamber(...)
	if not cv_chamber:GetBool() then return false end

	return BaseClass.CanChamber(self, ...)
end
