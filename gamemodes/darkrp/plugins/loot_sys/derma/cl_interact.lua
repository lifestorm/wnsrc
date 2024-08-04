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
AccessorFunc(PANEL, "actionType", "ActionType")
AccessorFunc(PANEL, "lootableEntity", "LootableEntity")

function PANEL:Init()
	if (IsValid(ix.gui.interactable)) then
		ix.gui.interactable:Remove()
	end
	self:SetSize(SScaleMin(550 / 3), SScaleMin(100 / 3))
	self:Center()
    ix.gui.interactable = self

	local topbar = self:Add("Panel")
	topbar:SetSize(self:GetWide(), SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function( this, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("OPTIONS DE CAISSE")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()

		surface.PlaySound("helix/ui/press.wav")
	end

	local buttonBox = self:Add("Panel")
	buttonBox:Dock(TOP)
	buttonBox:SetTall(SScaleMin(50 / 3))
    self.optionLeft = buttonBox:Add("ixInteractButton")
    self.optionLeft:Dock(LEFT)
    self.optionLeft:SetWide(self:GetWide() / 3)
    self.optionRight = buttonBox:Add("ixInteractButton")
    self.optionRight:Dock(LEFT)    
    self.optionRight:SetWide(self:GetWide() / 3)
    self.optionDown = buttonBox:Add("ixInteractButton")
    self.optionDown:Dock(LEFT)    
    self.optionDown:SetWide(self:GetWide() / 3)

    self:MakePopup()
end

function PANEL:UpdateButtons()
    local character = LocalPlayer():GetCharacter()
    local inv = character:GetInventory()
    if self:GetActionType() == 1 then 
        self.optionLeft:SetText("ENFREINDRE")
        self.optionLeft.DoClick = function()
            if not ix.loot:IsHavingTool(inv) then return LocalPlayer():Notify("You don't have any tools for it.") end
            netstream.Start("ixLootProceed", {tool = ix.loot:IsHavingTool(inv), act = self:GetActionType(), ent = self:GetLootableEntity(), tpy = 1})
            self:Remove()
        end
        self.optionLeft:SetHelixTooltip(function(tooltip)
            local lockpick = tooltip:AddRow("lockpick")
            lockpick:SetText("Briser avec des outils")
            lockpick:SizeToContents()
            
            local lockpick2 = tooltip:AddRow("lockpick2")
            lockpick2:SetText("Nécessite un outil spécial pour cette action. Violation du conteneur GARANTIE de laisser tomber tout le butin que ce conteneur peut avoir.")
            lockpick2:SizeToContents()
            if ix.loot:IsHavingTool(inv) then
                local lockpick3 = tooltip:AddRow("lockpick3")
                lockpick3:SetText("[VOUS AVEZ LES OUTILS POUR CETTE ACTION]")
                lockpick3:SizeToContents()
                lockpick3:SetBackgroundColor(Color(166, 255, 49))
            elseif not ix.loot:IsHavingTool(inv) then
                local lockpick3 = tooltip:AddRow("lockpick3")
                lockpick3:SetText("[VOUS N'AVEZ PAS D'OUTILS POUR CETTE ACTION]")
                lockpick3:SizeToContents()
                lockpick3:SetBackgroundColor(Color(255, 73, 49))
            end

            tooltip:SizeToContents()
        end)
        self.optionRight:SetText("OUVRIR")
        self.optionRight.DoClick = function()
            netstream.Start("ixLootProceed", {tool = false, act = self:GetActionType(), ent = self:GetLootableEntity(), tpy = 1})
            self:Remove()
        end
        self.optionRight:SetHelixTooltip(function(tooltip)
            local open1 = tooltip:AddRow("open1")
            open1:SetText("Caisse ouverte")
            open1:SizeToContents()
            
            local open2 = tooltip:AddRow("open2")
            open2:SetText("Vous avez la possibilité d'ouvrir ce conteneur, mais N'EST PAS GARANTI d'un butin complet.")
            open2:SizeToContents()

            tooltip:SizeToContents()
        end)
        self.optionDown:SetText("OUVERT DE FORCE")
        self.optionDown.DoClick = function()
            netstream.Start("ixLootProceed", {tool = false, act = self:GetActionType(), ent = self:GetLootableEntity(), tpy = 2})
            self:Remove()
        end
        self.optionDown:SetHelixTooltip(function(tooltip)
            local notif1 = tooltip:AddRow("notif1")
            notif1:SetText("Ouvrir en utilisant la force")
            notif1:SizeToContents()
            
            local notif2 = tooltip:AddRow("notif2")
            notif2:SetText("Vous ouvrirez ce conteneur instantanément, mais vous n'aurez pas de butin supplémentaire.")
            notif2:SizeToContents()

            tooltip:SizeToContents()
        end) 
    elseif self:GetActionType() == 2 then 
        if IsValid(self.optionRight) then self.optionRight:Remove() end 
        if IsValid(self.optionLeft) then self.optionLeft:Remove() end
        self.optionDown:SetText("ENFREINDRE")
        self.optionDown:SetWide(self:GetWide() / 1)
        self.optionDown.DoClick = function()
            netstream.Start("ixLootProceed", {tool = ix.loot:IsHavingTool(inv), act = self:GetActionType(), ent = self:GetLootableEntity(), tpy = 1})
            self:Remove()
        end
        self.optionDown:SetHelixTooltip(function(tooltip)
            local notif1 = tooltip:AddRow("notif1")
            notif1:SetText("Enfreindre")
            notif1:SizeToContents()
            
            local notif2 = tooltip:AddRow("notif2")
            notif2:SetText("Vous ne pouvez ouvrir ce conteneur qu'en le [INFRACTION].")
            notif2:SizeToContents()

            if ix.loot:IsHavingTool(inv) then
                local lockpick3 = tooltip:AddRow("lockpick3")
                lockpick3:SetText("[VOUS AVEZ DES OUTILS POUR CETTE ACTION]")
                lockpick3:SizeToContents()
                lockpick3:SetBackgroundColor(Color(166, 255, 49))
            elseif not ix.loot:IsHavingTool(inv) then
                local lockpick3 = tooltip:AddRow("lockpick3")
                lockpick3:SetText("[VOUS N'AVEZ PAS D'OUTILS POUR CETTE ACTION]")
                lockpick3:SizeToContents()
                lockpick3:SetBackgroundColor(Color(255, 73, 49))
            end

            tooltip:SizeToContents()
        end)
    elseif self:GetActionType() == 3 then 
        if IsValid(self.optionRight) then self.optionRight:Remove() end 
        if IsValid(self.optionLeft) then self.optionLeft:Remove() end
        self.optionDown:SetText("Utiliser la clé")
        self.optionDown:SetWide(self:GetWide() / 1)
        self.optionDown.DoClick = function()
            if not ix.loot:IsHavingKey(inv, self:GetLootableEntity().lootKey) then return end
            netstream.Start("ixLootProceed", {key = self:GetLootableEntity().lootKey, act = self:GetActionType(), ent = self:GetLootableEntity(), tpy = 1})
            self:Remove()
        end
        self.optionDown:SetHelixTooltip(function(tooltip)
            local notif1 = tooltip:AddRow("notif1")
            notif1:SetText("Clé")
            notif1:SizeToContents()
            
            local notif2 = tooltip:AddRow("notif2")
            notif2:SetText("Vous ne pouvez ouvrir cette caisse qu'en [UTILISANT] une clé spéciale dessus.")
            notif2:SizeToContents()

            if ix.loot:IsHavingKey(inv, self:GetLootableEntity().lootKey) then
                local lockpick3 = tooltip:AddRow("lockpick3")
                lockpick3:SetText("[VOUS AVEZ LA CLE DE CETTE CAISSE]")
                lockpick3:SizeToContents()
                lockpick3:SetBackgroundColor(Color(166, 255, 49))
            elseif not ix.loot:IsHavingKey(inv, self:GetLootableEntity().lootKey) then
                local lockpick3 = tooltip:AddRow("lockpick3")
                lockpick3:SetText("[VOUS N'AVEZ PAS LA CLE POUR CETTE CAISSE]")
                lockpick3:SizeToContents()
                lockpick3:SetBackgroundColor(Color(255, 73, 49))
            end

            tooltip:SizeToContents()
        end)
    end
end

function PANEL:Think()
    self:UpdateButtons()
end
function PANEL:Paint(width, height)
    surface.SetDrawColor(Color(0, 0, 0, 100))
    surface.DrawRect(0, 0, width, height)

    surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
    surface.DrawOutlinedRect(0, 0, width, height)
end

vgui.Register("ixInteractBasic", PANEL, "Panel")



netstream.Hook("IntToggle", function(data)
	if !IsValid(ix.gui.interactable) then 
		vgui.Create("ixInteractBasic")
	else 
		ix.gui.interactable:Remove()
	end
end)
 
netstream.Hook("ixLootInteractStart", function(data)
    local action = data.act 
    local ent = data.ent
    if !IsValid(ix.gui.interactable) then 
		local int = vgui.Create("ixInteractBasic")
        int:SetActionType(action)
        int:SetLootableEntity(ent)
	else  
		ix.gui.interactable:Remove()
	end 

end)