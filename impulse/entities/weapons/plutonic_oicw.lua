-- "addons\\plutonic\\lua\\weapons\\plutonic_oicw.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "OICW"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/tfa_misc/w_oicw.mdl")
SWEP.ViewModel = Model("models/weapons/tfa_misc/c_oicw.mdl")
SWEP.Attachments = {}
-- 2160286637
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("weapons/oicw/handling/oicw_bolt_release_01.wav")
SWEP.EmptySound = Sound("Weapon_AR2.Empty")

SWEP.Primary.Sound = Sound("weapons/tfa_misc/oicw/smg1_fire1.wav")
SWEP.Primary.Recoil = 0.4 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 12
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02 -- base spread value
SWEP.Primary.Delay = RPM(650)
SWEP.Primary.Tracer = "AR2Tracer"

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 5
SWEP.Spread.Max = 25
SWEP.Spread.IronsightsMod = 0.7 -- multiply
SWEP.Spread.CrouchMod = 0.7 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.4 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.1 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.16 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-2.75, 0, 2.85)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.7
SWEP.IronsightsSensitivity = 0.7
SWEP.IronsightsCrosshair = true
SWEP.IronsightsRecoilVisualMultiplier = 4
SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.6
SWEP.Spread.IronsightsMod = 0.45 -- multiply
SWEP.Spread.CrouchMod = 0.45 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.4 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.08 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.8 -- movement speed effect on spread (additonal)
SWEP.IronsightsRocking = 2
SWEP.IronsightsSpeed = 3
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.7
SWEP.IronsightsCrosshair = true
SWEP.BlowbackPos = Vector(0, -4, -0.2)
SWEP.BlowbackAngle = Angle()
SWEP.IronsightsMuzzleParticle = true
SWEP.MuzzleEffect = "muzzleflash_smg"

SWEP.LoweredPos = Vector(5.119, -1.921, -0.24)
SWEP.LoweredAng = Angle(-5.7, 29.7, -1.9)

SWEP.LowerAngles = Angle(23, -9, -2.4)
SWEP.LowerPos = Vector(-2, -8.6, -3)

sound.Add( {
	name = 'Weapon_OICW.Mag_Release',
	channel = CHAN_STATIC,
	volume = 1,
	level = 64,
	pitch = { 0, 1 },
	sound = 'weapons/oicw/handling/oicw_mag_release_01.wav'
} )
sound.Add( {
	name = 'Weapon_OICW.Mag_Out',
	channel = CHAN_STATIC,
	volume = 1,
	level = 64,
	pitch = { 0, 1 },
	sound = 'weapons/oicw/handling/oicw_mag_out_01.wav'
} )
sound.Add( {
	name = 'Weapon_OICW.Mag_Futz',
	channel = CHAN_STATIC,
	volume = 1,
	level = 64,
	pitch = { 0, 1 },
	sound = 'weapons/oicw/handling/oicw_mag_futz_01.wav'
} )
sound.Add( {
	name = 'Weapon_OICW.Mag_In',
	channel = CHAN_STATIC,
	volume = 1,
	level = 64,
	pitch = { 0, 1 },
	sound = 'weapons/oicw/handling/oicw_mag_in_01.wav'
} )
sound.Add( {
	name = 'Weapon_OICW.Mag_Slap',
	channel = CHAN_STATIC,
	volume = 1,
	level = 64, 
	pitch = { 0, 1 },
	sound = 'weapons/oicw/handling/oicw_mag_slap_01.wav'
} )
sound.Add( {
	name = 'Weapon_OICW.Bolt_Release',
	channel = CHAN_STATIC,
	volume = 1,
	level = 64,
	pitch = { 0, 1 },
	sound = 'weapons/oicw/handling/oicw_bolt_release_01.wav'
} )

function SWEP:Reload()
	
	if not self:CanReload() then return end

	self.Owner:DoReloadEvent()
	self:QueueIdle()

	if self.ReloadSound then 
		self:EmitSound(self.ReloadSound) 
	elseif self.OnReload then
		self.OnReload(self)
	end
	
	local sq = self:LookupSequence("reload")
	
	self:SetAnimation(sq)

	self:SetReloading( true )
	self:SetReloadTime( CurTime() + 1.25 )

	hook.Run("LongswordWeaponReload", self.Owner, self)
end