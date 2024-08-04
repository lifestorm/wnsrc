--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Holstered Weapons"
PLUGIN.author = "Black Tea"
PLUGIN.description = "Shows holstered weapons on players."

ix.config.Add(
	"showHolsteredWeps",
	true,
	"Whether or not holstered weapons show on players.",
	nil,
	{category = PLUGIN.name}
)

if (SERVER) then return end

HOLSTER_DRAWINFO = HOLSTER_DRAWINFO or {}

HOLSTER_DRAWINFO["arccw_go_usp"] = {
	pos = Vector(-10.5, -2, 3),
	ang = Angle(0, -95, 0),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/arccw_go/v_pist_usp.mdl"
}

HOLSTER_DRAWINFO["arccw_go_ak47"] = {
	pos = Vector(4, 0, -5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/w_rif_ak47.mdl"
}

HOLSTER_DRAWINFO["arccw_fml_volk_pkp"] = {
	pos = Vector(5, 0, -5),
	ang = Angle(0, 190, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw/fml/w_volked_pkp.mdl"
}

HOLSTER_DRAWINFO["arccw_go_m4"] = {
	pos = Vector(7, 20, 5),
	ang = Angle(0, 190, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_rif_m4a1.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_bat"] = {
	pos = Vector(5, 9, 0),
	ang = Angle(70, 0, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_bcd"] = {
	pos = Vector(0, -8, -1),
	ang = Angle(0, -90, 90),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_nmrih/w_tool_barricade.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_cleaver"] = {
	pos = Vector(0, -9, 1),
	ang = Angle(0, -90, 90),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_nmrih/w_me_cleaver.mdl"
}

HOLSTER_DRAWINFO["arccw_go_r8"] = {
	pos = Vector(-10.5, -1.5, 2),
	ang = Angle(0, -95, 0),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/arccw_go/v_pist_r8.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_crowbar"] = {
	pos = Vector(4, 6, 0),
	ang = Angle(70, 5, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
}

HOLSTER_DRAWINFO["arccw_go_aug"] = {
	pos = Vector(7, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_rif_aug.mdl"
}

HOLSTER_DRAWINFO["arccw_go_famas"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_rif_famas.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_fireaxe"] = {
	pos = Vector(0, -8, -1),
	ang = Angle(0, -90, 90),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_fubar"] = {
	pos = Vector(5, 8, -4),
	ang = Angle(70, 5, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/tfa_nmrih/w_me_fubar.mdl"
}

HOLSTER_DRAWINFO["arccw_go_ump"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_smg_ump45.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_hatchet"] = {
	pos = Vector(5, -8, -1),
	ang = Angle(0, -90, 90),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_nmrih/w_me_hatchet.mdl"
}

HOLSTER_DRAWINFO["arccw_spulse"] = {
	pos = Vector(6, 10, -3),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/srifle/w_srifle.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_kknife"] = {
	pos = Vector(0, -8, -1),
	ang = Angle(0, -90, 90),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_nmrih/w_me_kitknife.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_lpipe"] = {
	pos = Vector(4, 7, -1),
	ang = Angle(90, 5, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl"
}

HOLSTER_DRAWINFO["arccw_go_scar"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_rif_scar.mdl"
}

HOLSTER_DRAWINFO["wn_arccw_vsv"] = {
	pos = Vector(11, 13, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/c_VSV.mdl"
}

HOLSTER_DRAWINFO["arccw_go_m9"] = {
	pos = Vector(-13, -2.5, 2),
	ang = Angle(0, -95, 0),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/arccw_go/v_pist_m9.mdl"
}

HOLSTER_DRAWINFO["arccw_go_ssg08"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_snip_ssg08.mdl"
}

HOLSTER_DRAWINFO["arccw_go_m1014"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_shot_m1014.mdl"
}

HOLSTER_DRAWINFO["wn_arccw_metrorevolver"] = {
	pos = Vector(-20, 0.5, 2),
	ang = Angle(0, -100, 0),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/c_MetroRevolver.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_machete"] = {
	pos = Vector(8, -8, -1),
	ang = Angle(0, -90, 90),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_nmrih/w_me_machete.mdl"
}

HOLSTER_DRAWINFO["arccw_go_p2000"] = {
	pos = Vector(-13, -2.5, 2),
	ang = Angle(0, -95, 0),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/arccw_go/v_pist_p2000.mdl"
}

HOLSTER_DRAWINFO["arccw_oicw"] = {
	pos = Vector(6, -10, -2),
	ang = Angle(0, 270, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/oicw/w_oicw.mdl"
}

HOLSTER_DRAWINFO["arccw_gauss_rifle"] = {
	pos = Vector(6, -4, -8),
	ang = Angle(0, 280, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw/w_gauss_rifle.mdl"
}

HOLSTER_DRAWINFO["arccw_go_awp"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_snip_awp.mdl"
}

HOLSTER_DRAWINFO["arccw_go_mp5"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_smg_mp5.mdl"
}

HOLSTER_DRAWINFO["arccw_go_mp7"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_smg_mp7.mdl"
}

HOLSTER_DRAWINFO["arccw_go_p90"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_smg_p90.mdl"
}

HOLSTER_DRAWINFO["wn_arccw_tikhar"] = {
	pos = Vector(7, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/c_Tikhar.mdl"
}

HOLSTER_DRAWINFO["wn_arccw_helsing"] = {
	pos = Vector(11, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/c_Helsing.mdl"
}

HOLSTER_DRAWINFO["arccw_go_deagle"] = {
	pos = Vector(-13, -2.5, 2),
	ang = Angle(0, -95, 0),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/arccw_go/v_pist_deagle.mdl"
}

HOLSTER_DRAWINFO["arccw_go_fiveseven"] = {
	pos = Vector(-13, -2.5, 2),
	ang = Angle(0, -95, 0),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/arccw_go/v_pist_fiveseven.mdl"
}

HOLSTER_DRAWINFO["arccw_go_m249para"] = {
	pos = Vector(11, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_mach_m249para.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_pickaxe"] = {
	pos = Vector(2, 10, 2),
	ang = Angle(-90, 190, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/tfa_nmrih/w_me_pickaxe.mdl"
}

HOLSTER_DRAWINFO["arrcw_ar2"] = {
	pos = Vector(5, -4, -3),
	ang = Angle(0, 5, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/w_IRifle.mdl"
}

HOLSTER_DRAWINFO["arccw_ar21"] = {
	pos = Vector(3, 0, -3),
	ang = Angle(-5, 5, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/irifle2/w_irifle2.mdl"
}

HOLSTER_DRAWINFO["arccw_go_g3"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_rif_g3.mdl"
}

HOLSTER_DRAWINFO["wn_arccw_bastardgun"] = {
	pos = Vector(11, 16, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/c_BastardGun.mdl"
}

HOLSTER_DRAWINFO["wn_arccw_duplet"] = {
	pos = Vector(11, 13, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/c_duplet.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_sledge"] = {
	pos = Vector(4, 10, 0),
	ang = Angle(-90, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/tfa_nmrih/w_me_sledge.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_spade"] = {
	pos = Vector(4, 7, 0),
	ang = Angle(-90, 170, 180),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/tfa_nmrih/w_me_spade.mdl"
}

HOLSTER_DRAWINFO["arccw_go_870"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_shot_870.mdl"
}

HOLSTER_DRAWINFO["arccw_go_mac10"] = {
	pos = Vector(9, 20, 5),
	ang = Angle(0, 185, 0),
	bone = "ValveBiped.Bip01_Spine1",
	model = "models/weapons/arccw_go/v_smg_mac10.mdl"
}

HOLSTER_DRAWINFO["tfa_nmrih_wrench"] = {
	pos = Vector(0, -8, -1),
	ang = Angle(0, -90, 90),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_nmrih/w_me_wrench.mdl"
}

HOLSTER_DRAWINFO["tfa_csgo_decoy"] = {
	pos = Vector(2, 8, 0),
	ang = Angle(15, 0, 270),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_csgo/w_eq_decoy_thrown.mdl"
}

HOLSTER_DRAWINFO["tfa_rustalpha_flare"] = {
	pos = Vector(2, 8, 0),
	ang = Angle(15, 0, 270),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/yurie_rustalpha/wm-flare.mdl"
}

HOLSTER_DRAWINFO["tfa_csgo_flash"] = {
	pos = Vector(2, 8, 0),
	ang = Angle(15, 0, 270),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/w_eq_flashbang_dropped.mdl"
}

HOLSTER_DRAWINFO["tfa_mmod_grenade"] = {
	pos = Vector(2, 8, 0),
	ang = Angle(15, 0, 270),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/items/grenadeammo.mdl"
}

HOLSTER_DRAWINFO["tfa_csgo_incen"] = {
	pos = Vector(2, 8, 0),
	ang = Angle(15, 0, 270),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/w_eq_incendiarygrenade_dropped.mdl"
}

HOLSTER_DRAWINFO["tfa_csgo_smoke"] = {
	pos = Vector(2, 8, 0),
	ang = Angle(15, 0, 270),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/w_eq_smokegrenade_dropped.mdl"
}

HOLSTER_DRAWINFO["tfa_csgo_sonarbomb"] = {
	pos = Vector(2, 8, 0),
	ang = Angle(15, 0, 270),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/tfa_csgo/w_eq_sensorgrenade.mdl"
}

HOLSTER_DRAWINFO["ix_stunstick"] = {
	pos = Vector(4, 9, -2),
	ang = Angle(0, 100, 0),
	bone = "ValveBiped.Bip01_Pelvis",
	model = "models/weapons/w_stunbaton.mdl"
}

function PLUGIN:PostPlayerDraw(client)
	if (!ix.config.Get("showHolsteredWeps")) then return end
	if (!client:GetCharacter()) then return end

	if (client == LocalPlayer() and !client:ShouldDrawLocalPlayer()) then
		return
	end

	local weapon = client:GetActiveWeapon()
	local curClass = ((weapon and weapon:IsValid()) and weapon:GetClass():lower() or "")

	client.holsteredWeapons = client.holsteredWeapons or {}

	-- Clean up old, invalid holstered weapon models.
	for k, v in pairs(client.holsteredWeapons) do
		local weapon = client:GetWeapon(k)

		if (!IsValid(weapon)) then
			v:Remove()
		end
	end

	-- Create holstered models for each weapon.
	for _, v in ipairs(client:GetWeapons()) do
		local class = v:GetClass():lower()
		local drawInfo = HOLSTER_DRAWINFO[class]

		if (!drawInfo or !drawInfo.model) then continue end

		if (!IsValid(client.holsteredWeapons[class])) then
			local model = ClientsideModel(drawInfo.model, RENDERGROUP_TRANSLUCENT)
			model:SetNoDraw(true)

			client.holsteredWeapons[class] = model
		end

		local drawModel = client.holsteredWeapons[class]
		local boneIndex = client:LookupBone(drawInfo.bone)

		if (!boneIndex or boneIndex < 0) then continue end

		local bonePos, boneAng = client:GetBonePosition(boneIndex)

		if (curClass != class and IsValid(drawModel)) then
			local right = boneAng:Right()
			local up = boneAng:Up()
			local forward = boneAng:Forward()	

			boneAng:RotateAroundAxis(right, drawInfo.ang[1])
			boneAng:RotateAroundAxis(up, drawInfo.ang[2])
			boneAng:RotateAroundAxis(forward, drawInfo.ang[3])

			bonePos = bonePos
				+ drawInfo.pos[1] * right
				+ drawInfo.pos[2] * forward
				+ drawInfo.pos[3] * up

			drawModel:SetRenderOrigin(bonePos)
			drawModel:SetRenderAngles(boneAng)
			drawModel:DrawModel()
		end
	end
end

function PLUGIN:EntityRemoved(entity)
	if (entity.holsteredWeapons) then
		for _, v in pairs(entity.holsteredWeapons) do
			v:Remove()
		end
	end
end

for _, v in ipairs(player.GetAll()) do
	for _, v2 in ipairs(v.holsteredWeapons or {}) do
		v2:Remove()
	end

	v.holsteredWeapons = nil
end
