--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN
PLUGIN.ZipTiedActors = {}
PLUGIN.blur = ix.util.GetMaterial("pp/blurscreen")

do
    PLUGIN.ZipTiedAngles = {}
    PLUGIN.ZipTiedAngles["ValveBiped.Bip01_L_UpperArm"] = Angle(20, 8.8, 0)
    PLUGIN.ZipTiedAngles["ValveBiped.Bip01_L_UpperArm"] = Angle(20, 8.8, 0)
    PLUGIN.ZipTiedAngles["ValveBiped.Bip01_L_Forearm"]  = Angle(15, 0, 0)
    PLUGIN.ZipTiedAngles["ValveBiped.Bip01_L_Hand"]     = Angle(0, 0, 75)
    PLUGIN.ZipTiedAngles["ValveBiped.Bip01_R_Forearm"]  = Angle(-15, 0, 0)
    PLUGIN.ZipTiedAngles["ValveBiped.Bip01_R_Hand"]     = Angle(0, 0, -75)
    PLUGIN.ZipTiedAngles["ValveBiped.Bip01_R_UpperArm"] = Angle(-20, 16.6, 0)
end

PLUGIN.BaggedActors = {}

PLUGIN.LocalCharIsBagged = false

local BAG_MODEL_BASE  = "models/willardnetworks/m1nt/burlap_bag_" -- thanks kawa!
local BAG_MODEL_MALE  = "male.mdl"
local BAG_MODEL_FEM   = "female.mdl"
local BAG_POS_FEM     = Vector(-56, -25.1, 2)
local BAG_ANGLES_FEM  = Angle(182.6, 113.8, 88)
local BAG_POS_MALE    = Vector(-46, -42, -0.5)
local BAG_ANGLES_MALE = Angle(170, 130, 90)

local ResponseSelectRemoveBag = 1
local ResponseSelectUntie     = 2
local ResponseSelectDrag      = 3
local ResponseSelectRelease   = 4

local BlackScreenShader = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0.04,
	[ "$pp_colour_contrast" ] = 0.1,
	[ "$pp_colour_colour" ] = 0,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

hook.Add("HUDPaint", "draw_bag_on_head", function()
    if (PLUGIN.LocalCharIsBagged) then
        surface.SetMaterial(PLUGIN.blur)
        surface.SetDrawColor(255, 255, 255, 255)

        local x, y = 0, 0

        for i = -0.2, 1, 0.2 do
            PLUGIN.blur:SetFloat("$blur", i * 35) -- extreme blur
            -- only enough to see large objects right in front of them
            PLUGIN.blur:Recompute()

            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        end
	    DrawColorModify(BlackScreenShader)
		draw.SimpleText(
			"There is a bag placed over your head.",
			"WNBleedingTextNoClamp",
			ScrW() * 0.5,
			ScrH() - SScaleMin(250 / 3),
			Color(255, 78, 69, 255),
			TEXT_ALIGN_CENTER
		)
    end
end)

net.Receive("WNZipTieEnter", function(len)
    local targetId = net.ReadString()
    local targetPly = player.GetBySteamID64(targetId)
    if (!targetPly) then return end

	if (IsValid(targetPly) and targetPly:IsRestricted()) then
		PLUGIN.ZipTiedActors[targetId] = targetPly
    end
end)

net.Receive("WNZipTieExit", function(len)
    local targetId = net.ReadString()
    local targetPly = player.GetBySteamID64(targetId)
    if (!targetPly) then return end

	if (IsValid(targetPly)) then
		PLUGIN.ZipTiedActors[targetId] = nil

        PLUGIN:SetZipTiedBoneAngles(targetPly, true) -- reset bone angles
    end
end)

net.Receive("WNBagEnter", function(len)
    local targetId = net.ReadString()
    local targetPly = player.GetBySteamID64(targetId)
    if (!targetPly) then
        return
    end

    -- no need to draw a bag on our own character. the screen is black anyways

    if (targetId == LocalPlayer():SteamID64()) then
        PLUGIN.LocalCharIsBagged = true
        return
    end

    if (IsValid(targetPly)) then
		PLUGIN.BaggedActors[targetId] = {}
        PLUGIN.BaggedActors[targetId].actor = targetPly
        PLUGIN.BaggedActors[targetId].bagEnt = nil

        PLUGIN:SetupBagHead(targetId)
    end
end)

net.Receive("WNBagExit", function(len)
    local targetId = net.ReadString()
    local targetPly = player.GetBySteamID64(targetId)
    if (!targetPly) then return end

    if (targetId == LocalPlayer():SteamID64()) then
        PLUGIN.LocalCharIsBagged = false
        return
    end

    if (IsValid(targetPly)) then
        PLUGIN:RemoveBagHead(targetId)
    end
end)

net.Receive("WNDragOrBagPrompt", function(len)
    local isBagged = net.ReadBool()
    local isTied = net.ReadBool()
    local isFollowing = net.ReadBool()

    local frame = vgui.Create("Panel")
    frame:SetSize(SScaleMin(372 / 3), SScaleMin(300 / 3))
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(self, w, h)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
        surface.DrawRect(0, 0, w, h)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetMaterial(Material("willardnetworks/tabmenu/crafting/box_pattern.png", "noclamp"))
		surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, w / SScaleMin(300 / 3), h / SScaleMin(500 / 3))
    end

    local exit = frame:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
    exit:SetPos(SScaleMin(345 / 3), SScaleMin(10 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit.DoClick = function()
        net.Start("WNDragOrBagResponse")
            net.WriteInt(0, 5)
        net.SendToServer()

        frame:Remove()
        surface.PlaySound("helix/ui/press.wav")
	end

    local lastPosY = 100
    local addButton = function (text, selection)
        local button = vgui.Create("DButton", frame)
        button:SetText(text)
        button:SetFont("MenuFontNoClamp")
        button:SetTextColor(Color(255,255,255))
        button:CenterHorizontal()
        button:SetPos((frame:GetWide() / 2) - (SScaleMin(150 / 3) / 2), lastPosY)
        lastPosY = lastPosY + 60
        button:SetSize(SScaleMin(150 / 3), SScaleMin(30 / 3))
        button.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(63, 58, 115, 220))
            surface.SetMaterial(Material("willardnetworks/tabmenu/crafting/box_pattern.png", "noclamp"))
            surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, w / SScaleMin(414 / 3), h / SScaleMin(677 / 3))
        end
        button.DoClick = function()
            net.Start("WNDragOrBagResponse")
                net.WriteInt(selection, 4)
            net.SendToServer()

            frame:Remove()
            surface.PlaySound("helix/ui/press.wav")
        end
    end

    if (isBagged) then
        addButton("Remove Bag", ResponseSelectRemoveBag)
    end

    if (isTied) then
        addButton("Untie", ResponseSelectUntie)
    end

    if (isFollowing) then
        addButton("Release", ResponseSelectRelease)
    else
        addButton("Drag", ResponseSelectDrag)
    end
end)

function PLUGIN:Think()
    for _, actor in pairs(self.ZipTiedActors) do
        PLUGIN:SetZipTiedBoneAngles(actor, false)
    end
end

function PLUGIN:SetupBagHead(actorId)
    local actor = self.BaggedActors[actorId].actor
    if (!actor or !actor.IsFemale) then
        return
    end

    local mdl_str = BAG_MODEL_BASE
    if (actor:IsFemale()) then
        mdl_str = mdl_str..BAG_MODEL_FEM
        self.BaggedActors[actorId].pos = BAG_POS_FEM
        self.BaggedActors[actorId].ang = BAG_ANGLES_FEM
    else
        mdl_str = mdl_str..BAG_MODEL_MALE
        self.BaggedActors[actorId].pos = BAG_POS_MALE
        self.BaggedActors[actorId].ang = BAG_ANGLES_MALE
    end

    local bag = ClientsideModel(
        mdl_str,
        RENDER_GROUP_OPAQUE_ENTITY
    )

    if (!bag or !bag.SetNoDraw) then
        return
    end

    bag:SetNoDraw(true) -- remember, we're drawing manually here

    if (!actor.GetModelScale or !actor.LookupBone) then
        return
    end
    -- need to scale it up to set it to the model scale of the character (set by resizer plugin)
    bag:SetModelScale(actor:GetModelScale() or 1)

    local followBone = actor:LookupBone("ValveBiped.Bip01_Neck1")
    -- for characters with nonbipedal models (or models with no neck), we cant draw head bags!
    if (!followBone) then
        return
    end

    bag:FollowBone(actor, followBone)
    bag:SetPredictable(true)
    bag:SetLocalPos(self.BaggedActors[actorId].pos)
    bag:SetLocalAngles(self.BaggedActors[actorId].ang)

    local headBone = actor:LookupBone("ValveBiped.Bip01_Head1")
    if (!headBone) then
        return
    end

    self.BaggedActors[actorId].bagEnt = bag
    self.BaggedActors[actorId].headBone = headBone
end

function PLUGIN:RemoveBagHead(actorId)
    if (!self.BaggedActors[actorId]) then
        return
    end

    local actor = self.BaggedActors[actorId].actor
    local bag = self.BaggedActors[actorId].bagEnt
    if (IsValid(actor) and
        actor.ManipulateBoneScale and
        isnumber(self.BaggedActors[actorId].headBone)
    ) then
        actor:ManipulateBoneScale(
            self.BaggedActors[actorId].headBone, Vector(1, 1, 1))
        -- reset head scale
    end

    if (bag and bag.Remove) then
        bag:Remove()
    end

    self.BaggedActors[actorId] = nil
end

function PLUGIN:SetZipTiedBoneAngles(ply, bReset)
    if (!IsValid(ply) or !ply.GetAbsVelocity or !ply.IsPlayer or !ply:IsPlayer()) then
        return
    end

    if (bReset or ply:GetAbsVelocity() != Vector(0, 0, 0)) then
        -- ManipulateBoneAngles sorta breaks on animations. So the hands behind the back thing should only be set when idle
        local boneID
        for bone, _ in pairs(self.ZipTiedAngles) do
            boneID = ply:LookupBone(bone)
            if (boneID) then
                ply:ManipulateBoneAngles(boneID, Angle(0, 0, 0))
            end
        end
    else
        local boneID
        for bone, angle in pairs(self.ZipTiedAngles) do
            boneID = ply:LookupBone(bone)
            if (boneID) then
                ply:ManipulateBoneAngles(boneID, angle)
            end
        end
    end
end

hook.Add("PostDrawOpaqueRenderables", "draw_head_bags", function(_)
    -- I know this is a bit uncommon to do this in this particular hook
    -- But for some reason when we ragdoll it just, stops calling post PVS hooks sometimes
    -- Which means we can't use PostPlayerDraw here
    local plyEnt
    local pos
    local ang
    local ent
    for id, actor in pairs(PLUGIN.BaggedActors) do
        ent = actor.bagEnt
        pos = actor.pos
        ang = actor.ang

        if (!ent or
            !ent.SetLocalPos or
            !isvector(pos) or
            !isangle(ang) or
            !isnumber(actor.headBone)
        ) then
            -- yes we really do have to check this every frame
            -- sorry (thanks garry)
            PLUGIN:RemoveBagHead(id)
            continue
        else
            plyEnt = ent:GetParent()
            if (!plyEnt or !IsEntity(plyEnt) or !plyEnt:IsValid()) then
                continue -- dont draw if there is no valid parent (yet)
            end

            -- call in a pcall so we can handle any of these lovely errors
            local success, err = pcall(function()
                -- local to the parent's bone
                ent:SetLocalPos(pos)
                ent:SetLocalAngles(ang)

                ent:SetupBones()
                ent:DrawModel()

                -- do head shrinkage so it fits in da bag
                plyEnt:ManipulateBoneScale(actor.headBone, Vector(0.1, 0.1, 0.1))
            end)

            if (!success) then
                -- panic!
                -- printing here in case we get any bug reports:
                print("Error drawing head bag!")
                print(err)
                PLUGIN:RemoveBagHead(id)
            end
        end
    end
end)

-- sanity function to check for ragdolls, players, and/or invalid players
local function checkBaggedEntList()
    -- check all existing ragdolls to see if any of their players are bagged
    -- if so then, we need to set them as bagged ;)
    for _, ent in ipairs(ents.FindByClass("prop_ragdoll")) do
        if (!ent or !IsEntity(ent) or !ent:IsValid()) then
            -- NEVER trust gmod builtins
            continue
        end

        local ply = ent:GetNetVar("player")
        if (ply and
            IsEntity(ply) and
            IsValid(ply) and
            ply.IsPlayer and
            ply:IsPlayer() and
            ply != LocalPlayer()
        ) then
            local actor = PLUGIN.BaggedActors and PLUGIN.BaggedActors[ply:SteamID64()]
            if (actor and istable(actor)) then
                if (actor.bagEnt and
                    IsEntity(actor.bagEnt) and
                    actor.bagEnt:IsValid() and
                    actor.bagEnt:GetParent() != ent
                ) then
                    local followBone = ent:LookupBone("ValveBiped.Bip01_Neck1")
                    -- for characters with nonbipedal models (or models with no neck), we cant draw head bags!
                    if (!followBone) then
                        continue
                    end

                    actor.bagEnt:SetModelScale(ent:GetModelScale() or 1)
                    actor.bagEnt:FollowBone(ent, followBone)
                end
            end
        end
    end

    -- check the BaggedActors table for any inconsistencies
    for id, actor in pairs(PLUGIN.BaggedActors) do
        if (!actor.actor or !IsEntity(actor.actor) or !actor.actor:IsValid()) then
            PLUGIN:RemoveBagHead(id)
            -- player isn't valid, for some reason
        end

        if (!actor.bagEnt or !IsEntity(actor.bagEnt) or !actor.bagEnt:IsValid()) then
            PLUGIN:RemoveBagHead(id)
            -- bag entity isn't valid, for some reason
        end

        local parent = actor.bagEnt:GetParent()
        if (!IsEntity(parent) or !parent:IsValid()) then
            -- happens when the character gets up after being ragdolled
            PLUGIN:SetupBagHead(id) -- try to set up

            -- if it is still not valid, remove
            parent = actor.bagEnt:GetParent()
            if (!IsEntity(parent) or !parent:IsValid()) then
                PLUGIN:RemoveBagHead(id)
            end
        end
    end
end

function PLUGIN:InitializedPlugins()
    timer.Create("ValidateBaggedActors", 0.25, 0, function()
        checkBaggedEntList()
    end)
end
