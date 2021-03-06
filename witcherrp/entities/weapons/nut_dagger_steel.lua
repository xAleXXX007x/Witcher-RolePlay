
	AddCSLuaFile()


	SWEP.PrintName = "Стальной кинжал"
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
SWEP.dmgtype = 1

SWEP.Category = "WitcherRP"
SWEP.Author			= ""
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;
  
SWEP.ViewModel      = "models/morrowind/silver/dagger/v_silverdagger.mdl"
SWEP.WorldModel   = "models/morrowind/silver/dagger/w_silverdagger.mdl"
  
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 0.5

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "XBowBolt"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"				// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.RunArmOffset 		= Vector (0.3671, 0.1571, 5.7856)
SWEP.RunArmAngle	 		= Vector (-37.4833, 2.7476, 0)

SWEP.Sequence			= 0


util.PrecacheSound("weapons/knife/morrowind_knife_deploy1.wav")
util.PrecacheSound("weapons/knife/morrowind_knife_hitwall1.wav")
util.PrecacheSound("weapons/knife/morrowind_knife_hit.wav")
util.PrecacheSound("weapons/knife/morrowind_knife_slash.wav")

function SWEP:Initialize()
    	self:SetWeaponHoldType("knife")
	self.Hit = { 
	Sound( "weapons/knife/knife_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/knife/morrowind_knife_hit.wav") }
end


function SWEP:Precache()
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/knife/morrowind_knife_deploy1.wav")
	return true
end

function SWEP:PrimaryAttack()
	if( CurTime() < self.NextStrike ) then return; end
	
 	local trace = self.Owner:GetEyeTrace()
	
	local value = self.Owner:getLocalVar("stm", 0) - 15
	if (value <= 0) then
		return
	end
	if (SERVER) then
		self.Owner:setLocalVar("stm", value)
		self.Owner:getChar():updateAttrib("str", 0.001)
	end
	self.NextStrike = ( CurTime() + .5 )
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 50 then
		if( trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass()=="prop_ragdoll" ) then
			self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] )
		else
			self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] )
		end
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
			local skill = self.Owner:getChar():getAttrib("str")
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 1
				bullet.Damage = math.random(15, 20)
			self.Owner:FireBullets(bullet) 
	else
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		self.Weapon:EmitSound("weapons/knife/morrowind_knife_slash.wav")
	end
end

function RemoveKnife( ent )
	if ent:IsValid() then
		ent:Remove()
	end
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

end