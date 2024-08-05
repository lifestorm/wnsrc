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
	=============== Half Life Gonome SNPC Autorun ===============
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to load autorun file for Dummy
--------------------------------------------------*/
local PublicAddonName = "Half Life Gonome SNPC's Revamp"
local AddonName = "Half Life Gonome SNPC"
local AddonType = "NPC"
local AutorunFile = "autorun/vj_halflife_gonomes_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

local vCat = "Zombies + Enemy Aliens" -- Category
VJ.AddNPC("Gonome","npc_vj_hale_life_gonome",vCat)
VJ.AddNPC("Gonome Ver2","npc_vj_hale_life_gonome_2",vCat)
VJ.AddNPC("Explosive Gonome","npc_vj_hale_life_gonome_3",vCat)
VJ.AddNPC("Electrical Gonome","npc_vj_hale_life_gonome_4",vCat)
VJ.AddNPC("Entropy Zero 2 Gonome (Female)","npc_vj_ez2_gonome_fem",vCat)
VJ.AddNPC("Entropy Zero 2 Glownome (Female)","npc_vj_ez2_glownome_fem",vCat)
VJ.AddNPC("Entropy Zero 2 Gonome Classic Headcrab (Female)","npc_vj_ez2_gonome_classic_fem",vCat)
VJ.AddNPC("Entropy Zero 2 Gonome","npc_vj_ez2_gonome",vCat)
VJ.AddNPC("Entropy Zero 2 Glownome","npc_vj_ez2_glownome",vCat)
VJ.AddNPC("Entropy Zero 2 Gonome Classic Headcrab","npc_vj_ez2_gonome_classic",vCat)
VJ.AddNPC("Poison Gonome Ver2","npc_vj_hale_life_gonome_poison",vCat)
VJ.AddNPC("Entropy Zero 2 Gonome Remake (Cosmetic Only)","npc_vj_ez2_gonome_remake",vCat)
VJ.AddNPC("Gonome (Overcharged)","npc_vj_hale_life_gonome_overcharged",vCat)
VJ.AddNPC("Smod Gonome","npc_vj_hale_life_gonome_smod",vCat)
VJ.AddNPC("HL2 Beta Gonome","npc_vj_hale_life_beta_gonome",vCat)
VJ.AddNPC("RTBR Gonome","npc_vj_rtbr_gonome",vCat)
VJ.AddNPC("HL1 OpFor Gonome","npc_vj_half_life_op4_gonome",vCat)
VJ.AddNPC("HL1 Scientist Gonome","npc_vj_hl_gn_sci",vCat)
VJ.AddNPC("HL1 HECU Gonome","npc_vj_hl_gn_sol",vCat)
VJ.AddNPC("HL1 Security Gonome","npc_vj_hl_gn_grd",vCat)

VJ.AddParticle("particles/door_explosion.pcf",{"door_pound_core","door_exposion_chunks"})
VJ.AddParticle("particles/antlion_gib_02.pcf",{})
VJ.AddParticle("particles/antlion_gib_01.pcf",{})
VJ.AddParticle("particles/antlion_worker.pcf",{})
VJ.AddParticle("particles/aurora.pcf",{})


-- Menu --
	local AddConvars = {}
	AddConvars["vj_can_gonomes_knock_player_weapons"] = 1 -- Can SNPCs gain HP on successful kills?
	AddConvars["vj_can_gonomes_screen_fx"] = 0 -- Enable Screen Effects when hit?
	AddConvars["vj_can_gonomes_dance"] = 0 -- Can SNPCs dance?
	AddConvars["vj_can_gonomes_have_worldshake"] = 1 -- Do the Gonome's have worldshake?
	for k, v in pairs(AddConvars) do
		if !ConVarExists( k ) then CreateConVar( k, v, {FCVAR_ARCHIVE} ) end
	end

	if CLIENT then
	local function VJ_GO_MENU_MAIN(Panel)
		if !game.SinglePlayer() && !LocalPlayer():IsAdmin() then
			Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.not"})
			Panel:ControlHelp("#vjbase.menu.general.admin.only")
			return
		end		

		Panel:AddControl( "Label", {Text = "Notice: Only admins can change this settings."})	
		Panel:AddControl("Button",{Text = "#vjbase.menu.general.reset.everything", Command = " vj_can_gonomes_dance 0 \n vj_can_gonomes_have_worldshake 0 \n vj_can_gonomes_screen_fx 0 \n vj_can_gonomes_regain_hp 0"})

		Panel:AddControl("Checkbox", {Label = "Can Gonome's Dance?", Command = "vj_can_gonomes_dance"})
		Panel:ControlHelp("Allows Gonomes to dance whwen they get a kill.")

		Panel:AddControl("Checkbox", {Label = "Disable Gonome's worldshake?", Command = "vj_can_gonomes_have_worldshake"})
		Panel:ControlHelp("Allows Gonome's to have worldshake when they walk or run.")

		Panel:AddControl("Checkbox", {Label = "Disable Screen Effects when hit?", Command = "vj_can_gonomes_screen_fx"})
		Panel:ControlHelp("This allows whether the screen shake and blindness is applied to the player when hit.")

		Panel:AddControl("Checkbox", {Label = "Enable Gonome's Weapon Knocking Ability?", Command = "vj_can_gonomes_knock_player_weapons"})
		Panel:ControlHelp("This allows if a Gonome can knock the players weapon out of their hands.")
        end
	function VJ_ADDTOMENU_GO()
		spawnmenu.AddToolMenuOption( "DrVrej", "SNPC Configures", "HL Gonome SNPCs", "HL Gonome SNPCs", "", "", VJ_GO_MENU_MAIN, {} )
	end
		hook.Add( "PopulateToolMenu", "VJ_ADDTOMENU_GO", VJ_ADDTOMENU_GO )
	end


-- Don't edit anything below this! ------------------------------------------------
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
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end