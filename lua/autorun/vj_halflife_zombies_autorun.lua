--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "[VJ]Half-Life Zombies SNPCs"
local AddonName = "[VJ]Half-Life Zombies SNPCs"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_bms_autorun.lua"
-------------------------------------------------------
local VJExists = "lua/autorun/vj_base_autorun.lua"

if( file.Exists( VJExists, "GAME" ) ) then
	include('autorun/vj_controls.lua')
	AddCSLuaFile("autorun/vj_base_autorun.lua")
	AddCSLuaFile("autorun/vj_base_autorun.lua")
	AddCSLuaFile("autorun/vj_base_autorun.lua")
	VJ.AddAddonProperty(AddonName,AddonType)
end

if CLIENT then
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then
	chat.AddText(Color(0,200,200),PublicAddonName,
	Color(0,255,0)," was unable to install, you are missing ",
	Color(255,100,0),"VJ Base!"
	)
	end
end

timer.Simple(1,function()
	if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then
	if not VJF then
	if CLIENT then
	VJF = vgui.Create('DFrame')
	VJF:SetTitle("VJ Base is not installed")
	VJF:SetSize(900, 800)
	VJF:SetPos((ScrW() - VJF:GetWide()) / 2, (ScrH() - VJF:GetTall()) / 2)
	VJF:MakePopup()
	VJF.Paint = function()
	draw.RoundedBox( 8, 0, 0, VJF:GetWide(), VJF:GetTall(), Color( 200, 0, 0, 150 ) )
	end
	local VJURL = vgui.Create('DHTML')
	VJURL:SetParent(VJF)
	VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
	local x,y = VJF:GetSize()
	VJURL:SetSize(x*0.99,y*0.96)
	VJURL:SetAllowLua(true)
	VJURL:OpenURL('https://sites.google.com/site/vrejgaming/vjbasemissing')
	elseif SERVER then
	timer.Create("VJBASEMissing", 5, 0, function() print("VJ Base is Missing! Download it from the workshop!") end)
   end
  end
 end
end)