
	AddCSLuaFile()



	SWEP.PrintName = "Фамильный двуручный меч"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false


SWEP.Category = "WitcherRP"
SWEP.Author			= ""
SWEP.Base			= "nut_claymore_base"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
  
SWEP.ViewModel      = "models/morrowind/silver/claymore/v_silver_claymore.mdl"
SWEP.WorldModel   = "models/morrowind/silver/claymore/w_silver_claymore.mdl"

SWEP.Primary.Damage		= 25
SWEP.Primary.NumShots		= 0
SWEP.Primary.Delay 		= 1.5

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace()
	local value = self.Owner:getLocalVar("stm", 0) - 45
	if (value <= 0) then
		return
	end
	if (SERVER) then
		self.Owner:setLocalVar("stm", value)
		self.Owner:getChar():updateAttrib("str", 0.001)
	end
	if !self.Owner then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		local trace = self.Owner:GetEyeTrace()
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
			if( trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass()=="prop_ragdoll" ) then
				self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] )
			else
				self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] )
			end
				local skill = self.Owner:getChar():getAttrib("str")
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 1
				bullet.Damage = math.random(30, 40)
			self.Owner:FireBullets(bullet) 
			self.Owner:ViewPunch(Angle(7, 0, 0))
		else
			self.Weapon:EmitSound("weapons/claymore/morrowind_claymore_slash.wav")
		end
end
