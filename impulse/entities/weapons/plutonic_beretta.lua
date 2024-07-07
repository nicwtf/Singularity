-- "addons\\plutonic\\lua\\weapons\\plutonic_beretta.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base" 

SWEP.PrintName = "Berreta M9"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/tfa_ins2/c_beretta.mdl"
SWEP.WorldModel = "models/weapons/tfa_ins2/w_m9.mdl"
SWEP.ViewModelFOV = 55

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

sound.Add({
	name = "CUST.Weapn_berreta.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = {
		"weapons/tfa_ins2/m9/fire_1.wav",
                "weapons/tfa_ins2/m9/fire_2.wav",
                "weapons/tfa_ins2/m9/fire_3.wav",
	}
})

SWEP.Attachments = {}
SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")
SWEP.Primary.Sound = Sound("CUST.Weapn_berreta.Single")
SWEP.Primary.Recoil = .5 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 9.6
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.06
SWEP.Primary.Delay = 0.03

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 15
SWEP.Primary.DefaultClip = 15

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.4 -- multiply
SWEP.Spread.CrouchMod = 0.9 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 1.3 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-2.22, 10.5, 0.47)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = .67
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.MuzzleFlashAttachment = "muzzle"
SWEP.BlowbackPos = Vector(0.0, -2, -0.01) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle = Angle(0.0, -0, 0)

SWEP.IronsightsFireActivity = "ACT_VM_PRIMARYATTACK"

function SWEP:QueueIdle()
end

function SWEP:CustomShootEffects()
	self:PlayAnim(ACT_VM_PRIMARYATTACK)
end