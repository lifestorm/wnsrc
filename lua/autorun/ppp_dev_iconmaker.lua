--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

--[[
	This is a utility to generate icons. You can accomplish some stuff through the console command,
	but it's usually easier to just edit the source code.

	Frequently used colors
	
	combine 60,115,140
	synth 210,150,70
	bird 50,86,34
	fun 220,0,255 (4th in pallet)
	shotgunner 140 84 60
	vort mid 2nd from right in pallet
	zombie+headcrab middle-ish maroon
	resistance upper right

	-TF2-
	normal 200,60,60
	robots grey 109, in bottom
	spooky mid row, 1/3 from the right
	weapons 197 175 145
	fun 4th from left

	-PORTAL-
	1 - White
	2 - Dirty blue second row
]]
if CLIENT then
    local matBack = Material("icongen/back.png")
    local matFront = Material("icongen/front.png")

    concommand.Add("pk_dev_iconmaker", function(ply, cmd, args, str)
        local frame = vgui.Create("DFrame")
        frame:SetPos(ScrW() / 2 - 270, ScrH() / 2 - 150) --ScrW() ScrH()
        frame:SetSize(540, 300)
        frame:SetTitle("Icon Maker")
        frame:SetVisible(true)
        frame:SetDraggable(false)
        frame:ShowCloseButton(true)
        frame:MakePopup()
        local color = vgui.Create("DColorMixer", frame)
        color:SetPos(10, 30)
        color:SetAlphaBar(false)
        --color:SetColor(Color(200,60,60)) tf2 default red
        color:SetColor(Color(200, 60, 60))
        local model = vgui.Create("DAdjustableModelPanel", frame)
        model:SetPos(270, 30)
        model:SetSize(256, 256)
        model:SetLookAt(Vector(0, 0, 0))
        model:SetModel(args[1] ~= "" and args[1] or "models/props_junk/watermelon01.mdl")
        model:SetCamPos(Vector(100, 100, 100))
        local ent = model:GetEntity()

        --ent:SetRenderAngles(Angle(180,0,0))
        if args[2] then
            model:SetAnimated(true)
            ent:ResetSequence(ent:LookupSequence(args[2]))
        end

        --Custom
        model:GetEntity():SetSkin(1)
        --model:GetEntity():SetBodygroup(2,1)
        --model:GetEntity():SetBodygroup(1,1)
        --[[model:GetEntity():SetBodygroup(2,1)
		model:GetEntity():SetBodygroup(3,1)
		model:GetEntity():SetBodygroup(4,1)]]
        --model:GetEntity():SetMaterial("Models/antlion_guard/antlionGuard2")
        --model:GetEntity():SetSkin(2)
        --model:GetEntity():SetBodygroup(3,1)
        --model:GetEntity():SetColor(Color(120,70,210))
        local superPaint = model.Paint

        function model:Paint()
            surface.SetDrawColor(color:GetColor())
            surface.SetMaterial(matBack)
            surface.DrawTexturedRect(0, 0, model:GetWide(), model:GetTall())
            superPaint(model)
            cam.IgnoreZ(true)
            surface.SetDrawColor(Color(255, 255, 255, 255))
            surface.SetMaterial(matFront)
            surface.DrawTexturedRect(0, 0, model:GetWide(), model:GetTall())
            cam.IgnoreZ(false)
        end
    end)
end
