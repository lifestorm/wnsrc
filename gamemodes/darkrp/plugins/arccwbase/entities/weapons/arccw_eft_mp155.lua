--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Willard - Modern Weaponry" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP-155"
SWEP.TrueName = "MP-155"
SWEP.Trivia_Class = "Semi-automatic shotgun"
SWEP.Trivia_Desc = "Russian smoothbore multi-shot MP-155 12 gauge shotgun, manufactured by IzhMekh (\"Izhevsky Mechanical Plant\"). The gun weighs less than its predecessor MP-153 and features enhanced ergonomics and an easy-to-replace barrel mechanism. The new design also makes it easier to use for left-handed users."
SWEP.Trivia_Manufacturer = "Izhmekh"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Gas-operated Rotating bolt"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = 2017 

SWEP.Slot = 4

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/darsu_eft/c_mp153.mdl"
SWEP.WorldModel = "models/weapons/arccw/darsu_eft/c_mp153.mdl"
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = "1415003000"

SWEP.Num = 8 -- number of shots per trigger pull.
SWEP.Damage = 10
SWEP.DamageMin = 10 -- damage done at maximum range
SWEP.RangeMin  = 20 -- in METRES
SWEP.Range = 90 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 4 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 8

SWEP.PhysBulletMuzzleVelocity = 415

SWEP.TriggerDelay = false

SWEP.ReloadInSights = true
SWEP.ReloadInSights_FOVMult = 1

SWEP.Recoil = 2.5
SWEP.RecoilSide = 2

SWEP.RecoilRise = 0.3
SWEP.RecoilPunch = 2.5
SWEP.VisualRecoilMult = 10
SWEP.RecoilPunchBackMax = 18
SWEP.RecoilPunchBackMaxSights = 19 -- may clip with scopes

SWEP.Delay = 60 / 120 -- 60 / RPM.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 48 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 350 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 300

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses
SWEP.MagID = "MP153" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = {"weapons/darsu_eft/mp153/mr153_fire_close1.wav", "weapons/darsu_eft/mp153/mr153_fire_close2.wav"}
SWEP.ShootSoundSilenced = "weapons/darsu_eft/mp153/mr133_fire_silenced_close.wav"
SWEP.DistantShootSound = {"weapons/darsu_eft/mp153/mr153_fire_distant1.wav", "weapons/darsu_eft/mp153/mr153_fire_distant2.wav"}

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_shell.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.CamAttachment = 3 -- if set, this attachment will control camera movement

SWEP.SpeedMult = 0.94
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.5*1.07

SWEP.IronSightStruct = {
    Pos = Vector(-4.281, -2, 0.681),
    Ang = Angle(0.25, 0.004, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.Jamming = false
SWEP.HeatCapacity = 9
SWEP.HeatDissipation = 0.3
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatFix = true -- when the "fix" animation is played, all heat is restored.

SWEP.Malfunction = false
SWEP.MalfunctionJam = false -- After a malfunction happens, the gun will dryfire until reload is pressed. If unset, instead plays animation right after.
SWEP.MalfunctionTakeRound = false -- When malfunctioning, a bullet is consumed.
SWEP.MalfunctionWait = 0 -- The amount of time to wait before playing malfunction animation (or can reload)
SWEP.MalfunctionMean = 48 -- The mean number of shots between malfunctions, will be autocalculated if nil
SWEP.MalfunctionVariance = 0.2 -- The fraction of mean for variance. e.g. 0.2 means 20% variance
SWEP.MalfunctionSound = "weapons/arccw/malfunction.wav"

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0.2, -3.5, 0.7)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-1.2, -4.5, 0.2)
SWEP.CrouchAng = Angle(0, 0, -6)

SWEP.HolsterPos = Vector(0.2, -3.5, 0.7)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)
SWEP.BarrelOffsetCrouch = Vector(0, 0, -2)

SWEP.CustomizePos = Vector(0.2, -3.5, 0.7)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.BarrelLength = 28

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    [1] = {"shellport", "patron_in_weapon"},
}

SWEP.AttachmentElements = {
	["sightmount"] = {VMBodygroups = {{ind = 4, bg = 1}},},
    ["bottommount"] = {VMBodygroups = {{ind = 5, bg = 2}},},


    ["m5"] = {VMBodygroups = {{ind = 3, bg = 6}},},
    ["m6"] = {VMBodygroups = {{ind = 3, bg = 7}},},
    ["m7"] = {VMBodygroups = {{ind = 3, bg = 8}},},
    ["m8"] = {VMBodygroups = {{ind = 3, bg = 9}},},
    
    ["ultimapistol"] = {
        VMBodygroups = {{ind = 6, bg = 4}},
        Override_IronSightStruct = {
            Pos = Vector(-4.281, -4.5, -1.0),
            Ang = Angle(0.25, 0.004, 0),
            Magnification = 1.5,
        }
    },
    ["ultimatoprail"] = {
        VMBodygroups = {{ind = 4, bg = 2}},
        AttPosMods = {
            [1] = {
                vpos = Vector(0, 19, 2.9),
                vang = Angle(0, -90, 0),
            },
        },
        Override_IronSightStruct = {
            Pos = Vector(-4.281, -4.5, -1.0),
            Ang = Angle(0.25, 0.004, 0),
            Magnification = 1.5,
        },
        NameChange = "MP-155 Ultima",
        TrueNameChange = "MP-155 Ultima",
    },
    ["ultimastock"] = {VMBodygroups = {{ind = 8, bg = 1}},},
    
    ["ultimapistolend"] = {VMBodygroups = {{ind = 7, bg = 1}},},
    ["ultimastockendL"] = {VMBodygroups = {{ind = 7, bg = 2}},},
    ["ultimastockendM"] = {VMBodygroups = {{ind = 7, bg = 3}},},
    ["ultimastockendS"] = {VMBodygroups = {{ind = 7, bg = 4}},},

    ["ultimacamera"] = {VMBodygroups = {{ind = 9, bg = 1}},},

    ["ultimahg"] = {VMBodygroups = {{ind = 2, bg = 2}},},

    ["12rip"] = {VMBodygroups = {{ind = 10, bg = 1}},},
    ["12fl"] = {VMBodygroups = {{ind = 10, bg = 2}},},
    ["12dss"] = {VMBodygroups = {{ind = 10, bg = 3}},},
    ["12bmg"] = {VMBodygroups = {{ind = 10, bg = 4}},},
    ["12ap20"] = {VMBodygroups = {{ind = 10, bg = 5}},},
    ["12ftx"] = {VMBodygroups = {{ind = 10, bg = 6}},},
    ["12g40"] = {VMBodygroups = {{ind = 10, bg = 7}},},
    ["12cop"] = {VMBodygroups = {{ind = 10, bg = 8}},},
    ["12p3"] = {VMBodygroups = {{ind = 10, bg = 9}},},
    ["12p6u"] = {VMBodygroups = {{ind = 10, bg = 10}},},
    ["12sfp"] = {VMBodygroups = {{ind = 10, bg = 11}},},

    ["12lead"] = {VMBodygroups = {{ind = 10, bg = 10}},},
}

SWEP.ExtraSightDist = 6
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-10, 5.5, -2),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.ShotgunReload = true
SWEP.Attachments = {
	{
        PrintName = "Optic", -- print name
        DefaultAttName = "None",
		//DefaultAttIcon = Material("vgui/entities/eft_attachments/usp_sights_standard.png"),
        Slot = {"eft_optic_small", "eft_optic_medium", "eft_optic_large"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
		CorrectiveAng = Angle(0, 180, 0), 
        InstalledEles = {"sightmount"},
        Offset = {
            vpos = Vector(0, 17, 2.7),
            vang = Angle(0, -90, 0),
        },
    },
    {
        PrintName = "Bodykit", -- print name
        DefaultAttName = "Default",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/mp155_kit_std.png"),
        Slot = "eft_mp155_kit", -- what kind of attachments can fit here, can be string or table
        GivesFlags = {"ultima"},
    },
    {
        PrintName = "Muzzle Device",
        Slot = "eft_muzzle_12g",
        Bone = "weapon",
        DefaultAttName = "None",
        -- DefaultAttIcon = Material("vgui/entities/eft_attachments/att_scarl_muzzle_std.png"),
        Offset = {
            vpos = Vector(0, 40, 1.8),
            vang = Angle(90, -90, -90),
        },
    },
    {
        PrintName = "Magazine", -- print name
        DefaultAttName = "4-shell",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/mp153_m4.png"),
        Slot = "eft_mp153_mag", -- what kind of attachments can fit here, can be string or table
        Installed = "mag_eft_mp153_6",
    },    
    {
        PrintName = "Stock", -- print name
        DefaultAttName = "Walnut stock",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/mp155_stock_std.png"),
        Slot = "eft_mp155_stock", -- what kind of attachments can fit here, can be string or table
        GivesFlags = {"ultimacam"},
    },
    {
        PrintName = "Right Tactical", -- print name
        DefaultAttName = "No Tactical",
        Slot = {"eft_tactical"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        RequireFlags = {"ultima"},
        HideIfBlocked = true,
        Offset = {
            vpos = Vector(-1.17, 33.4, 1.7),
            vang = Angle(0, -90, -90),
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = "eft_foregrip",
        Bone = "mod_mount_000",
        DefaultAttName = "No Underbarrel",
        Offset = {
            vpos = Vector(0, -5.5, -1.2),
            vang = Angle(90, -90, -90),
        },
        InstalledEles = {"bottommount"},
        RequireFlags = {"ultima"},
    },
    {
        PrintName = "Top Gadget", -- print name
        DefaultAttName = "No Tactical",
        Slot = {"eft_tactical_big", "eft_mp155_tac"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        RequireFlags = {"ultima"},
        HideIfBlocked = true,
        Offset = {
            vpos = Vector(0, 33, 2.9),
            vang = Angle(0, -90, 180),
        },
    },
	{
        PrintName = "Ammo",
		DefaultAttName = "12/70 7mm buckshot",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/ammo/12g_def.png"),
        Slot = "ammo_eft_12"
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },

    ["draw"] = {
        Source = "draw",
        Time = 1.2,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_draw.wav",  t = 0},
        },
    },

	["holster"] = {
        Source = "holster",
        Time = 1.2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_holster.wav",  t = 0},
        },
    },

    ["ready"] = {
        Source = {"ready0", "ready1", "ready2"},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_draw.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr153_slider_up.wav",  t = 0.4},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 0.8},
        },
    },

    ["fire"] = {
        Source = "fire",
        Time = 0.15,
        ShellEjectAt = 0.05,
        SoundTable = {
            {s = "eft_shared/weap_trigger_hammer.wav", t = 0.05}
        },
    },


    ["sgreload_start"] = {
        Source = "reload_start",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
        },
    },    
    ["sgreload_start_empty"] = {
        Source = "reload_start_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr133_shell_pickup.wav",  t = 0.15},
            {s = "weapons/darsu_eft/mp153/mr133_shell_in_port.wav",  t = 0.85},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 1.2},
        },
    },
    ["sgreload_insert"] = {
        Source = "reload_loop",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_shell_pickup.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr133_shell_in_mag2.wav",  t = 0.3},
        },
    },    
    ["sgreload_finish"] = {
        Source = "reload_end",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "eft_shared/weap_handon.wav",  t = 0.1},
        },
    },

	["enter_inspect"] = {
		Source = "enter_inspect",
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
        },
	},

	["idle_inspect"] = {
		Source = "idle_inspect",
	},
	["exit_inspect"] = {
		Source = "exit_inspect",
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_draw.wav",  t = 0.2},
            {s = "weapons/darsu_eft/mp153/mr153_slider_up.wav",  t = 1.2},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 1.8},
        },
	},
	["unjam"] = {
		Source = {"jam0","jam1","jam2"},
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr153_slider_up.wav",  t = 0.8},
            {s = "weapons/darsu_eft/mp153/mr133_shell_out_mag.wav",  t = 1.2},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 1.52},
        },
	},
    ["fix"] = {
		Source = {"misfire0","misfire1","misfire2"},
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        -- ShellEjectAt = 0.8,
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr153_slider_up.wav",  t = 0.7},
            {s = "weapons/darsu_eft/mp153/mr133_shell_out_mag.wav",  t = 0.75},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 0.9},
        },
	},
}



if CLIENT then
    -- Stuff to always draw thermal on this shotgun if camera is installed
    -- Mostly copied from arccw's cl_holosight.lua

    local blackColor = Color(0, 0, 0)

    local rtsize = ScrH()
    local rtmat = GetRenderTarget("arccw_rtmat_ultima", rtsize, rtsize, false)

    local rtmaterial = CreateMaterial( "arccw_rtmat_ultima", "UnlitGeneric", {
        ['$basetexture'] = rtmat:GetName(),
    } );

    local colormod2 = Material("pp/colour")
    local pp_ca_base, pp_ca_r, pp_ca_g, pp_ca_b = Material("pp/arccw/ca_base"), Material("pp/arccw/ca_r"), Material("pp/arccw/ca_g"), Material("pp/arccw/ca_b")
    local pp_ca_r_thermal, pp_ca_g_thermal, pp_ca_b_thermal = Material("pp/arccw/ca_r_thermal"), Material("pp/arccw/ca_g_thermal"), Material("pp/arccw/ca_b_thermal")

    pp_ca_r:SetTexture("$basetexture", render.GetScreenEffectTexture())
    pp_ca_g:SetTexture("$basetexture", render.GetScreenEffectTexture())
    pp_ca_b:SetTexture("$basetexture", render.GetScreenEffectTexture())

    pp_ca_r_thermal:SetTexture("$basetexture", render.GetScreenEffectTexture())
    pp_ca_g_thermal:SetTexture("$basetexture", render.GetScreenEffectTexture())
    pp_ca_b_thermal:SetTexture("$basetexture", render.GetScreenEffectTexture())

    local coldtime = 30

    local reticle = Material("hud/scopes/ultimareticle6.png")

    function SWEP:UltimaFormRTScope()
        cam.Start3D()

        -- ArcCW.Overdraw = true
        -- ArcCW.LaserBehavior = true
        -- ArcCW.VMInRT = true

        local rtangles, rtpos, rtdrawvm

        if GetConVar("arccw_drawbarrel"):GetBool() and GetConVar("arccw_vm_coolsway"):GetBool() then
            rtangles = self.VMAng - self.VMAngOffset
            rtangles.x = rtangles.x - self.VMPosOffset_Lerp.z * 10
            rtangles.y = rtangles.y + self.VMPosOffset_Lerp.y * 10

            rtpos = self.VMPos + self.VMAng:Forward() * 15
        else
            rtangles = EyeAngles()
            rtpos = EyePos()
        end

        local addads = 1

        local rt = {
            w = rtsize,
            h = rtsize,
            angles = rtangles,
            origin = rtpos,
            drawviewmodel = false,
            fov = 15,
        }

        rtsize = ScrH()

        if ScrH() > ScrW() then rtsize = ScrW() end

        local rtres = ScrH()*0.2
        
        rtmat = GetRenderTarget("arccw_rtmat_ultima", rtres, rtres, false)

        render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)

        render.ClearRenderTarget(rt, blackColor)

        -- if self:GetState() == ArcCW.STATE_SIGHTS then
            render.RenderView(rt)
            cam.Start3D(EyePos(), EyeAngles(), rt.fov, 0, 0, nil, nil, 0, nil)
                self:DoLaser(false)
            cam.End3D()
        -- end

        -- ArcCW.Overdraw = false
        -- ArcCW.LaserBehavior = false
        -- ArcCW.VMInRT = false

        -- self:FormPP(rtmat)

        render.PopRenderTarget()

        cam.End3D()

        -- if asight.Thermal then
            self:UltimaFormThermalImaging(rtmat)
        -- end
    end

    local function IsWHOT(ent)
        if !ent:IsValid() or ent:IsWorld() then return false end
    
        if ent:IsPlayer() then -- balling
            if ent.ArcticMedShots_ActiveEffects and ent.ArcticMedShots_ActiveEffects["coldblooded"] or ent:Health() <= 0 then return false end -- arc stims
            return true
        end
    
        if ent:IsNPC() or ent:IsNextBot() then -- npcs
            if ent.ArcCWCLHealth and ent.ArcCWCLHealth <= 0 or ent:Health() <= 0 then return false end
            return true
        end
    
        if ent:IsRagdoll() then -- ragdolling
            if !ent.ArcCW_ColdTime then ent.ArcCW_ColdTime = CurTime() + coldtime end
            return ent.ArcCW_ColdTime > CurTime()
        end
    
        if ent:IsVehicle() or ent:IsOnFire() or ent.ArcCW_Hot or ent:IsScripted() and !ent:GetOwner():IsValid() then -- vroom vroom + :fire: + ents but not guns (guns on ground will be fine)
            return true
        end
    
        return false
    end

    function SWEP:UltimaFormThermalImaging(tex)
        if !tex then
            tex = render.GetRenderTarget()
        end

        render.PushRenderTarget(tex)

        cam.Start3D()

        if tex then
            colormod2:SetTexture("$fbtexture", tex)
        else
            colormod2:SetTexture("$fbtexture", render.GetScreenEffectTexture())
        end

        local nvsc = {r=255+0, g=255+1, b=255+16/255}
        local tvsc = {r=-255, g=-255, b=-255}

        local tab = ents.GetAll()

        -- table.Add(tab, player.GetAll())
        -- table.Add(tab, ents.FindByClass("npc_*"))

        render.SetStencilEnable(true)
        render.SetStencilWriteMask(255)
        render.SetStencilTestMask(255)
        render.ClearStencil()

        local sw = ScrH()
        local sh = sw

        local sx = (ScrW() - sw) / 2
        local sy = (ScrH() - sh) / 2

        render.SetScissorRect( sx, sy, sx + sw, sy + sh, true )

        render.SetStencilReferenceValue(64)

        render.SetStencilPassOperation(STENCIL_REPLACE)
        render.SetStencilFailOperation(STENCIL_KEEP)
        render.SetStencilZFailOperation(STENCIL_KEEP)
        render.SetStencilCompareFunction(STENCIL_ALWAYS)

        for _, v in pairs(tab) do

            if !IsWHOT(v) then continue end

            -- if !asight.ThermalScopeSimple then
                render.SetBlend(0.5)
                render.SuppressEngineLighting(true)

                render.SetColorModulation(250, 250, 250)

                v:DrawModel()
            -- end
        end

        render.SetColorModulation(1, 1, 1)

        render.SuppressEngineLighting(false)

        render.MaterialOverride()

        render.SetBlend(1)

        render.SetStencilCompareFunction(STENCIL_EQUAL)


        DrawColorModify({
            ["$pp_colour_addr"] = 0,
            ["$pp_colour_addg"] = 0,
            ["$pp_colour_addb"] = 0,
            ["$pp_colour_brightness"] = 0,
            ["$pp_colour_contrast"] = 1,
            ["$pp_colour_colour"] = 0,
            ["$pp_colour_mulr"] = 0,
            ["$pp_colour_mulg"] = 0,
            ["$pp_colour_mulb"] = 0
        })

        DrawColorModify({
            ["$pp_colour_addr"] = tvsc.r - 255,
            ["$pp_colour_addg"] = tvsc.g - 255,
            ["$pp_colour_addb"] = tvsc.b - 255,
            ["$pp_colour_addr"] = 0,
            ["$pp_colour_addg"] = 0,
            ["$pp_colour_addb"] = 0,
            ["$pp_colour_brightness"] = 0,
            ["$pp_colour_contrast"] = 1,
            ["$pp_colour_colour"] = 1,
            ["$pp_colour_mulr"] = 0,
            ["$pp_colour_mulg"] = 0,
            ["$pp_colour_mulb"] = 0
        })

        -- if !asight.ThermalNoCC then
            render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
            render.SetStencilPassOperation(STENCIL_KEEP)

            
            if GetConVar("arccw_thermalpp"):GetBool() and GetConVar("arccw_scopepp"):GetBool() then
                -- chromatic abberation
                
                render.CopyRenderTargetToTexture(render.GetScreenEffectTexture())

                render.SetMaterial( pp_ca_base )
                render.DrawScreenQuad()
                render.SetMaterial( pp_ca_r_thermal )
                render.DrawScreenQuad()
                render.SetMaterial( pp_ca_g_thermal )
                render.DrawScreenQuad()
                render.SetMaterial( pp_ca_b_thermal )
                render.DrawScreenQuad()
                -- pasted here cause otherwise either target colors will get fucked either pp either motion blur
            end

            DrawColorModify({
                ["$pp_colour_addr"] = nvsc.r - 255,
                ["$pp_colour_addg"] = nvsc.g - 255,
                ["$pp_colour_addb"] = nvsc.b - 255,
                -- ["$pp_colour_addr"] = 0,
                -- ["$pp_colour_addg"] = 0,
                -- ["$pp_colour_addb"] = 0,
                ["$pp_colour_brightness"] = 0.1,
                ["$pp_colour_contrast"] = 0.5,
                ["$pp_colour_colour"] = 0.12,
                ["$pp_colour_mulr"] = 0,
                ["$pp_colour_mulg"] = 0,
                ["$pp_colour_mulb"] = 0
            })
        -- end

        render.SetScissorRect( sx, sy, sx + sw, sy + sh, false )

        render.SetStencilEnable(false)

        colormod2:SetTexture("$fbtexture", render.GetScreenEffectTexture())

        cam.End3D()
        
        if GetConVar("arccw_thermalpp"):GetBool() then
            if !render.SupportsPixelShaders_2_0() then return end

            DrawSharpen(0.3,0.9)
            DrawBloom(0,0.3,5,5,3,0.5,1,1,1)
            -- DrawMotionBlur(0.7,1,1/(15)) -- seems to break shit
        end


        cam.Start2D()
            surface.SetMaterial(reticle)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(0, 0, ScrH(), ScrH())
        cam.End2D()

        render.PopRenderTarget()
    end

    local fpsdelay = CurTime()

    hook.Add("RenderScene", "ArcCW_ULTIMA_CAM", function()
        local wpn = LocalPlayer():GetActiveWeapon()

        if wpn.ArcCW and wpn:GetClass() == "arccw_eft_mp155" and wpn.Attachments[8].Installed == "tac_eft_mp155_ultima_camera" then
            if fpsdelay > CurTime() then return end
            wpn:UltimaFormRTScope()
            wpn.Owner:GetViewModel():SetSubMaterial(28, "!arccw_rtmat_ultima")
            fpsdelay = CurTime()+1/15
        end
    end)
end