--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PANEL = {}

function PANEL:Init()
    local w, h = ScrW() * 0.5, ScrH() * 0.5
    self:SetSize(w, h)
    self:MakePopup()
    self:SetDraggable(true)
    self:SetTitle("Icon Editor")
    self:Center()

    local buttonSize = 48

    self.model = vgui.Create("DAdjustableModelPanel", self)
    self.model:SetSize(w * 0.5, h - buttonSize)
    self.model:Dock(LEFT)
    self.model:DockMargin(0, 0, 0, buttonSize + 8)
    self.model:SetModel("models/props_borealis/bluebarrel001.mdl")
    self.model:SetLookAt(Vector(0, 0, 0))
    self.model.LayoutEntity = function()
    end

    local x = 4

    self.best = vgui.Create("DButton", self)
    self.best:SetSize(buttonSize, buttonSize)
    self.best:SetPos(x, h - buttonSize - 4)
    self.best:SetText("Best")
    self.best.DoClick = function()
        local entity = self.model:GetEntity()
        local pos = entity:GetPos()
        local camData = PositionSpawnIcon(entity, pos)

        if camData then
            self.model:SetCamPos(camData.origin)
            self.model:SetFOV(camData.fov)
            self.model:SetLookAng(camData.angles)
        end
    end

    x = x + buttonSize + 4

    self.front = vgui.Create("DButton", self)
    self.front:SetSize(buttonSize, buttonSize)
    self.front:SetPos(x, h - buttonSize - 4)
    self.front:SetText("Front")
    self.front.DoClick = function()
        local entity = self.model:GetEntity()
        local pos = entity:GetPos()
        local camPos = pos + Vector(-200, 0, 0)

        self.model:SetCamPos(camPos)
        self.model:SetFOV(45)
        self.model:SetLookAng((camPos * -1):Angle())
    end

    x = x + buttonSize + 4

    self.above = vgui.Create("DButton", self)
    self.above:SetSize(buttonSize, buttonSize)
    self.above:SetPos(x, h - buttonSize - 4)
    self.above:SetText("Above")
    self.above.DoClick = function()
        local entity = self.model:GetEntity()
        local pos = entity:GetPos()
        local camPos = pos + Vector(0, 0, 200)

        self.model:SetCamPos(camPos)
        self.model:SetFOV(45)
        self.model:SetLookAng((camPos * -1):Angle())
    end

    x = x + buttonSize + 4

    self.right = vgui.Create("DButton", self)
    self.right:SetSize(buttonSize, buttonSize)
    self.right:SetPos(x, h - buttonSize - 4)
    self.right:SetText("Right")
    self.right.DoClick = function()
        local entity = self.model:GetEntity()
        local pos = entity:GetPos()
        local camPos = pos + Vector(0, 200, 0)

        self.model:SetCamPos(camPos)
        self.model:SetFOV(45)
        self.model:SetLookAng((camPos * -1):Angle())
    end

    x = x + buttonSize + 4

    self.center = vgui.Create("DButton", self)
    self.center:SetSize(buttonSize, buttonSize)
    self.center:SetPos(x, h - buttonSize - 4)
    self.center:SetText("Center")
    self.center.DoClick = function()
        local entity = self.model:GetEntity()
        local pos = entity:GetPos()

        self.model:SetCamPos(pos)
        self.model:SetFOV(45)
        self.model:SetLookAng(Angle(0, -180, 0))
    end

    self.best:DoClick()

    self.preview = vgui.Create("DPanel", self)
    self.preview:Dock(FILL)
    self.preview:DockMargin(4, 0, 0, 0)
    self.preview:DockPadding(4, 4, 4, 4)
    self.preview.Paint = function(pnl, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
    end

    self.modelPath = vgui.Create("DTextEntry", self.preview)
    self.modelPath:SetValue(self.model:GetModel())
    self.modelPath:Dock(TOP)
    self.modelPath.OnEnter = function(pnl)
        local model = pnl:GetValue()

        if model and model != "" then
            self.model:SetModel(model)
            self.item:Rebuild(true)
        end
    end

    self.slotSize = vgui.Create("DNumSlider", self.preview)
    self.slotSize:Dock(TOP)
    self.slotSize:SetText("Icon Scale")
    self.slotSize:SetMinMax(1, 512)
    self.slotSize:SetDecimals(0)
    self.slotSize:SetValue(64)
    self.slotSize.OnValueChanged = function(pnl, value)
        self.item:Rebuild(true)
    end

    self.width = vgui.Create("DNumSlider", self.preview)
    self.width:Dock(TOP)
    self.width:SetText("Item Width (Slots)")
    self.width:SetMinMax(1, 16)
    self.width:SetDecimals(0)
    self.width:SetValue(1)
    self.width.OnValueChanged = function(pnl, value)
        self.item:Rebuild(true)
    end

    self.height = vgui.Create("DNumSlider", self.preview)
    self.height:Dock(TOP)
    self.height:SetText("Item Height (Slots)")
    self.height:SetMinMax(1, 16)
    self.height:SetDecimals(0)
    self.height:SetValue(1)
    self.height.OnValueChanged = function(pnl, value)
        self.item:Rebuild(true)
    end

    self.itemPanel = vgui.Create("DPanel", self.preview)
    self.itemPanel:Dock(FILL)
    self.itemPanel.Paint = function(pnl, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
    end

    self.item = vgui.Create("ixItemIcon", self.itemPanel)
    self.item:SetMouseInputEnabled(false)
    self.item.LayoutEntity = function()
    end
    self.item.PaintOver = function(pnl, w, h)
        surface.SetDrawColor(color_white)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local lastCamData = {}

    self.item.Rebuild = function(pnl, forceRebuild)
        local slotSize = self.slotSize:GetValue()
        local padding = 2
        local slotW, slotH = math.Round(self.width:GetValue()), math.Round(self.height:GetValue())
        local w, h = slotW * (slotSize + padding) - padding, slotH * (slotSize + padding) - padding
        local pos = self.model:GetCamPos()
        local newPos = Vector(-pos.x, -pos.y, pos.z)
        local ang = self.model:GetLookAng()
        local newAng = Angle(ang.p, ang.y + 180, ang.r)
        local camData = {
            cam_pos = newPos,
            cam_ang = newAng,
            cam_fov = self.model:GetFOV()
        }

        if (camData.cam_pos != lastCamData.cam_pos
        or camData.cam_ang != lastCamData.cam_ang
        or camData.cam_fov != lastCamData.cam_fov
        or forceRebuild) then
            pnl:SetModel(self.model:GetModel())
            lastCamData = camData
            pnl.Icon:RebuildSpawnIconEx(camData)
            pnl:SetSize(w, h)
            pnl:Center()
        end
    end

    self.item:Rebuild(true)

    timer.Create("ixIconEditorUpdate", 0.5, 0, function()
        if IsValid(self) and IsValid(self.model) then
            self.item:Rebuild()
        else
            timer.Remove("ixIconEditorUpdate")
        end
    end)

    self.copy = vgui.Create("DButton", self)
    self.copy:SetSize(buttonSize, buttonSize)
    self.copy:SetPos(w - buttonSize - 12, h - buttonSize - 12)
    self.copy:SetText("Copy")
    self.copy.DoClick = function()
        local camPos = self.model:GetCamPos()
        local camAng = self.model:GetLookAng()
        local str = 'ITEM.model = "'..self.model:GetModel()..'"\n'
            .."ITEM.width = "..math.Round(self.width:GetValue()).."\n"
            .."ITEM.height = "..math.Round(self.height:GetValue()).."\n"
            .."ITEM.iconCam = {\n"
            .."  pos = Vector("..math.Round(-camPos.x, 2)..", "..math.Round(-camPos.y, 2)..", "..math.Round(camPos.z, 2).."),\n"
            .."  ang = Angle("..math.Round(camAng.p, 2)..", "..math.Round(camAng.y + 180, 2)..", "..math.Round(camAng.r, 2).."),\n"
            .."  fov = "..math.Round(self.model:GetFOV(), 2).."\n"
            .."}\n"

        SetClipboardText(str)

        LocalPlayer():Notify("The code was copied to your clipboard.")
    end
end

vgui.Register("ixIconEditor", PANEL, "DFrame")
