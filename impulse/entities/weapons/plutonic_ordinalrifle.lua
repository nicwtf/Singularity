-- "addons\\plutonic\\lua\\weapons\\plutonic_ordinalrifle.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "AR-1"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_ordinalrifle.mdl")
SWEP.Attachments = {}
SWEP.ViewModel = Model("models/weapons/c_ordinalrifle.mdl")
SWEP.ViewModelFOV = 60
SWEP.BarrelLength = 7

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.AirboatMuzzleFlash = true

sound.Add({
	name = "Weapon_AR1.Single",
	sound = "ar1/fire1.wav", "ar1/fire2.wav", "ar1/fire12.wav", "ar1/fire11.wav", "ar1/fire10.wav", "ar1/fire3.wav", "ar1/fire4.wav", "ar1/fire5.wav", "ar1/fire6.wav", "ar1/fire7.wav", "ar1/fire8.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})

SWEP.ReloadSound = Sound("weapons/hlvr/irifle/reload.wav")
SWEP.EmptySound = Sound("Weapon_AR2.Empty")

SWEP.Primary.Sound = Sound("Weapon_AR1.Single")
SWEP.Primary.Recoil = 0.54 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Burst = false
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = RPM(675)
SWEP.Primary.Tracer = "AR2Tracer"
SWEP.Primary.PenetrationScale = 2
SWEP.Primary.RecoilUp = 0.15
SWEP.Primary.RecoilDown = 0.15
SWEP.Primary.RecoilSide = 0.15

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 40
SWEP.Primary.DefaultClip = 40

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.CannotChamber = true
SWEP.Spread = {}
SWEP.Spread.Min = 0.015
SWEP.Spread.Max = 0.035
SWEP.Spread.IronsightsMod = 0.45 -- multiply
SWEP.Spread.CrouchMod = 0.45 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.4 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.08 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.8 -- movement speed effect on spread (additonal)
SWEP.IronsightsRocking = 2
SWEP.IronsightsSpeed = 3
SWEP.IronsightsPos = Vector(-3.28, -4.841, 0.62)
SWEP.IronsightsAng = Angle(0, 0, -.2)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.7
SWEP.IronsightsCrosshair = false
SWEP.BlowbackPos = Vector(0, -1.5, -00)
SWEP.BlowbackAngle = Angle()
SWEP.IronsightsMuzzleParticle = true
SWEP.IronsightsMuzzleFlash = "muzzleflash_smg"
SWEP.MuzzleFlashSize = 256
SWEP.MuzzleFlashBrightness = 6
SWEP.MuzzleFlashColor = Color(18, 140, 20)

SWEP.LoweredPos = Vector(5.119, -1.921, -0.24)
SWEP.LoweredAng = Angle(-5.7, 29.7, -1.9)

SWEP.LowerAngles = Angle(-10, 5, -0)
SWEP.LowerPos = Vector(-0, -0, -0)

function SWEP:QueueIdle()
end

function SWEP:CustomShootEffects()
end