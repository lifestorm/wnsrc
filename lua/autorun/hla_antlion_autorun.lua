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
	*** Copyright (c) 2012-2021 by Mayhem, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Half-Life: Alyx - Antlion"
local AddonName = "Half-Life: Alyx - Antlion"
local AddonType = "SNPC"
local AutorunFile = "autorun/hla_antlion_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
---------------------------------------------------------------------------------------------------------------------------
sound.AddSoundOverrides("lua/sound/hla_antlions.lua")
---------------------------------------------------------------------------------------------------------------------------
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Half-Life: Alyx"
	VJ.AddNPC("Antlion","npc_vj_hla_antlion",vCat)
	VJ.AddNPC("Antlion  Spitter","npc_vj_hla_antlion_spitter",vCat)
	--VJ.AddNPC("Antlion AI Director","sent_vj_antlion_director",vCat,true) -- Currently broken
	
	-- Menu --
	VJ.AddConVar("vj_antlion_director_enabled",1)
	VJ.AddConVar("vj_antlion_director_max",80)
	VJ.AddConVar("vj_antlion_director_hordecount",35)
	VJ.AddConVar("vj_antlion_director_spawnmax",300)
	VJ.AddConVar("vj_antlion_director_spawnmin",100)
	VJ.AddConVar("vj_antlion_director_hordechance",100)
	VJ.AddConVar("vj_antlion_director_hordecooldownmin",120)
	VJ.AddConVar("vj_antlion_director_hordecooldownmax",180)
	VJ.AddConVar("vj_antlion_director_delaymin",0.85)
	VJ.AddConVar("vj_antlion_director_delaymax",3)
	
	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_HLA", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Half-Life: Alyx - Antlion Director", "Half-Life: Alyx - Antlion Director", "", "", function(Panel)
				if !game.SinglePlayer() then
				if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
					Panel:AddControl( "Label", {Text = "You are not an admin!"})
					Panel:ControlHelp("Notice: Only admins can change rest of the settings.")
					return
					end
				end
				Panel:AddControl("Label", {Text = "Notice: Only admins can change this settings."})
				Panel:AddControl("Checkbox", {Label = "Enable AI Director processing?", Command = "vj_antlion_director_enabled"})
				Panel:AddControl("Slider", { Label 	= "Max Antlions", Command = "vj_antlion_director_max", Type = "Float", Min = "5", Max = "400"})
				Panel:AddControl("Slider", { Label 	= "Min Distance they can spawn from players", Command = "vj_antlion_director_spawnmin", Type = "Float", Min = "150", Max = "30000"})
				Panel:AddControl("Slider", { Label 	= "Max Distance they can spawn from players", Command = "vj_antlion_director_spawnmax", Type = "Float", Min = "150", Max = "30000"})
				Panel:AddControl("Slider", { Label 	= "Min time between spawns", Command = "vj_antlion_director_delaymin", Type = "Float", Min = "0.1", Max = "15"})
				Panel:AddControl("Slider", { Label 	= "Max time between spawns", Command = "vj_antlion_director_delaymax", Type = "Float", Min = "0.2", Max = "15"})
				Panel:AddControl("Slider", { Label 	= "Max Horde Antlions", Command = "vj_antlion_director_hordecount", Type = "Float", Min = "5", Max = "400"})
				Panel:AddControl("Slider", { Label 	= "Chance that a horde will appear", Command = "vj_antlion_director_hordechance", Type = "Float", Min = "1", Max = "500"})
				Panel:AddControl("Slider", { Label 	= "Min cooldown time for horde spawns", Command = "vj_antlion_director_hordecooldownmin", Type = "Float", Min = "1", Max = "800"})
				Panel:AddControl("Slider", { Label 	= "Max cooldown time for horde spawns", Command = "vj_antlion_director_hordecooldownmax", Type = "Float", Min = "1", Max = "800"})
			end, {})
		end)
	end
	
	VJ_ANT_NODEPOS = {}
	hook.Add("EntityRemoved","VJ_AddNodes_Antlion",function(ent)
		if ent:GetClass() == "info_node" then
			table.insert(VJ_ANT_NODEPOS,ent:GetPos())
		end
	end)
	
	VJ.AddCategoryInfo(vCat,{Icon = "vj_icons/AntlionLogoHLA.png"})
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("VJ Base is not installed")
				VJF:SetSize(900,800)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				local VJURL = vgui.Create("DHTML")
				VJURL:SetParent(VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				local x,y = VJF:GetSize()
				VJURL:SetSize(x*0.99,y*0.96)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end
