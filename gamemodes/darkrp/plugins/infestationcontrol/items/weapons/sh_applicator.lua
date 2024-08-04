--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "applicatorItemName"
ITEM.model = Model("models/jq/hlvr/props/xen/combine_foam_applicator.mdl")
ITEM.description = "applicatorItemDesc"
ITEM.category = "Infestation Control"
ITEM.class = "weapon_applicator"
ITEM.weaponCategory = "primary"
ITEM.exRender = true
ITEM.width = 5
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(0, 270, 0),
	fov = 12.05
}

-- Inventory drawing
if (CLIENT) then
	-- Draw camo if it is available.
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip", false)) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

ITEM.functions.Attach = {
	icon = "icon16/basket_put.png",
	OnRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor()
		local target = trace.Entity

		if (target:GetClass() == "ix_infestation_tank" and trace.HitPos:Distance(client:GetShootPos()) <= 192) then
			if (target:GetApplicatorAttached()) then
				client:NotifyLocalized("applicatorAttachFailureAttached")

				return false
			end

            if (!target:GetHoseAttached()) then
                client:NotifyLocalized("applicatorAttachFailureNoHose")

                return false
            end

			target:SetBodygroup(target:FindBodygroupByName("Applicator"), 0)
			target:SetApplicatorAttached(true)
			client:NotifyLocalized("applicatorAttachSuccess")
		else
			client:NotifyLocalized("invalidTank")

			return false
		end
	end,
	OnCanRun = function(item)
		return !item:GetData("connected", false) and !IsValid(item.entity)
	end
}

function ITEM:Equip(client, bNoSelect, bNoSound)
	if (!client:GetNetVar("tankHose", nil)) then
		client:NotifyLocalized("applicatorEquipFailureNoHose")

		return false
	end

	local items = client:GetCharacter():GetInventory():GetItems()

	client.carryWeapons = client.carryWeapons or {}

	for _, v in pairs(items) do
		if (v.id != self.id) then
			local itemTable = ix.item.instances[v.id]

			if (!itemTable) then
				client:NotifyLocalized("tellAdmin", "wid!xt")

				return false
			else
				if (itemTable.isWeapon and client.carryWeapons[self.weaponCategory] and itemTable:GetData("equip")) then
					client:NotifyLocalized("weaponSlotFilled", self.weaponCategory)

					return false
				end
			end
		end
	end

	if (client:HasWeapon(self.class)) then
		client:StripWeapon(self.class)
	end

	local weapon = client:Give(self.class, !self.isGrenade)

	if (IsValid(weapon)) then
		local ammoType = weapon:GetPrimaryAmmoType()

		client.carryWeapons[self.weaponCategory] = weapon

		if (!bNoSelect) then
			client:SelectWeapon(weapon:GetClass())
		end

		if (!bNoSound) then
			client:EmitSound(self.useSound, 80)
		end

		-- Remove default given ammo.
		if (client:GetAmmoCount(ammoType) == weapon:Clip1() and self:GetData("ammo", 0) == 0) then
			client:RemoveAmmo(weapon:Clip1(), ammoType)
		end

		-- assume that a weapon with -1 clip1 and clip2 would be a throwable (i.e hl2 grenade)
		-- TODO: figure out if this interferes with any other weapons
		if (weapon:GetMaxClip1() == -1 and weapon:GetMaxClip2() == -1 and client:GetAmmoCount(ammoType) == 0) then
			client:SetAmmo(1, ammoType)
		end

		self:SetData("equip", true)

		if (self.isGrenade) then
			weapon:SetClip1(1)
			client:SetAmmo(0, ammoType)
		else
			weapon:SetClip1(self:GetData("ammo", 0))
		end

		weapon.ixItem = self

		if (self.OnEquipWeapon) then
			self:OnEquipWeapon(client, weapon)
		end
	else
		print(Format("[Helix] Cannot equip weapon - %s does not exist!", self.class))
	end
end

function ITEM:OnLoadout()
	self:SetData("equip", false)
end
