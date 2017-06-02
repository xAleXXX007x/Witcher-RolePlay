	AddCSLuaFile()



	SWEP.PrintName = "Стальной палаш"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
SWEP.Category = "WitcherRP"
SWEP.Author			= ""
SWEP.Base			= "nut_broadsword_base"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
  
SWEP.ViewModel      = "models/morrowind/imperial/broadsword/v_imperial_broadsword.mdl"
SWEP.WorldModel   = "models/morrowind/imperial/broadsword/w_imperial_broadsword.mdl"

SWEP.Primary.NumShots		= 0
SWEP.Primary.Delay 		= 0.8

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

function SWEP:PrimaryAttack()
	if !self.Owner then return end
	local trace = self.Owner:GetEyeTrace()
	local value = self.Owner:getLocalVar("stm", 0) - 25
	if (value <= 0) then
		return
	end
	if (SERVER) then
		self.Owner:setLocalVar("stm", value)
		self.Owner:getChar():updateAttrib("str", 0.001)
	end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
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
				bullet.Damage = math.random( 25, 35 )
			self.Owner:FireBullets(bullet) 
			self.Owner:ViewPunch(Angle(7, 0, 0))
		else
			self.Weapon:EmitSound("weapons/broadsword/morrowind_broadsword_slash.wav")
		end
end