--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.HasMeleeAttack = false -- Turned off so that we can use the combo system instead
ENT.AnimTbl_MeleeAttack = nil
ENT.TimeUntilMeleeAttackDamage = false

ENT.ComboStrings = { -- Combos will trigger in the order the animations are placed, 1>2>3 or 2>1>3
	{
		--"attack1",
		--"attack2",
		--"attack3",
	},
	{
		--"attack5",
		--"attack2",
	},
	{
		--"attack1",
		--"attack2",
		--"attack6",
	},
	{
		--"attack6",
		--"attack7",
	},
	{
		--"attack6",
		--"attack8",
	},
	{
		--"attack16",
		--"attack15",
		--"attack12",
	},
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.CurrentStringTable = {}
	self.StringCount = 0
	self.CurrentStringNum = 0
	self.CurrentStringAnim = nil
	self.Attacking = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "JumpTable(24)" then -- Combo event, used to initiate a combo if we can
		self:CheckCanContinueString()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local ent = self:GetEnemy()
	local dist = self.NearestPointToEnemyDistance
	local cont = self.VJ_TheController
	local key_atk = IsValid(cont) && cont:KeyDown(IN_ATTACK)

	if IsValid(ent) && !self:IsBusy() then
		if key_atk or !IsValid(cont) && dist <= self.MeleeAttackDistance && !self.Attacking && self:CheckCanSee(ent,55) then
			self:Attack()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Attack()
	if !self.CanMeleeAttack then return end
	if self.Attacking then return end
	if self:IsBusy() then return end
	for k,v in RandomPairs(self.ComboStrings) do
		self:PlayString(true,v)
		break
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayString(init,tbl)
	if !isstring(tbl[1]) then
		tbl[1](self)
		return
	end
	self.Attacking = true
	if init then
		self.CurrentStringTable = tbl
		self.StringCount = #tbl
		self.CurrentStringNum = 1
	else
		self.CurrentStringNum = self.CurrentStringNum +1
	end
	self.CurrentStringAnim = tbl[self.CurrentStringNum]
	self:VJ_ACT_PLAYACTIVITY(self.CurrentStringAnim,true,false,false)
	if self.CurrentStringNum == self.StringCount then
		self.Attacking = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CheckContinueString()
	if self.CurrentStringNum +1 <= self.StringCount then
		self.vACT_StopAttacks = false
		self:PlayString(false,self.CurrentStringTable)
	else
		self.Attacking = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CheckCanContinueString()
	if (self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_ATTACK)) or !self.VJ_IsBeingControlled && IsValid(self:GetEnemy()) && self:GetEnemy():GetPos():Distance(self:GetPos()) <= 240 && self:CheckCanSee(self:GetEnemy(),55) then
		self:CheckContinueString()
	else
		self.Attacking = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CheckCanSee(ent,cone)
	return (self:GetSightDirection():Dot((ent:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(cone)))
end