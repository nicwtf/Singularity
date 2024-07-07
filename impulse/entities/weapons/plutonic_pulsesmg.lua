-- "addons\\plutonic\\lua\\weapons\\plutonic_pulsesmg.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base" 

SWEP.PrintName = "Pulse SMG"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/psmg/w_psmg.mdl")
SWEP.ViewModel = Model("models/weapons/psmg/c_psmg.mdl")
SWEP.ViewModelFOV = 55
SWEP.ViewModelOffset = Vector(0, 0, -2)
SWEP.ViewModelOffsetAng = Angle(0, 0, 0)

SWEP.Slot = 2
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = true

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("Weapon_AR2.Empty")

SWEP.Attachments = {}
sound.Add({
	name="PSMG.Shots",
	sound={
		"^psmg/smg1_fire1.wav",
		"^psmg/smg1_fire2.wav",
		"^psmg/smg1_fire3.wav",
		"^psmg/smg1_fire4.wav",
		"^psmg/smg1_fire5.wav",
		"^psmg/smg1_fire6.wav",
		"^psmg/smg1_fire7.wav",
		"^psmg/smg1_fire8.wav",
		"^psmg/smg1_fire9.wav",
		"^psmg/smg1_fire10.wav",
		"^psmg/smg1_fire11.wav",
		"^psmg/smg1_fire12.wav",
		"^psmg/smg1_fire13.wav",
		"^psmg/smg1_fire14.wav",
		"^psmg/smg1_fire15.wav",
		"^psmg/smg1_fire16.wav"
	},
	channel=CHAN_STATIC,
	pitch = {95, 105},
	volume = {0.95, 1},
	level = 143
})

sound.Add({
	name="PSMG.Reload",
	sound={
		"^psmg/eblaster_screw_in_01.wav",
		"psmg/eblaster_screw_in_02.wav",
		"psmg/eblaster_screw_in_03.wav",
		"psmg/eblaster_screw_in_04.wav"
	},
	channel=CHAN_STATIC,
	pitch = {95, 105},
	volume = {0.95, 1},
	level = 143
})

SWEP.Primary.Sound = Sound("PSMG.Shots")
SWEP.Primary.Recoil = .23 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 12.23
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.076
SWEP.Primary.Delay = 0.09
SWEP.Primary.Tracer = "AR2Tracer"

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.3
SWEP.Spread.IronsightsMod = 0.4 -- multiply
SWEP.Spread.CrouchMod = 0.9 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0 -- movement speed effect on spread (additonal)

SWEP.SwayLevel = 1
SWEP.SwayIdle = 0.8
SWEP.SwayRightMultiplier = 3.5
SWEP.SwayUpMultiplier = 3.4

SWEP.IronsightsRocking = 2
SWEP.IronsightsSpeed = 3
SWEP.IronsightsPos = Vector(-4.64, -3, 1.41)
SWEP.IronsightsAng = Angle(0.0, 0.0, 0)
SWEP.IronsightsFOV = .9
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2
SWEP.BlowbackPos = Vector(0, -4, -00)
SWEP.BlowbackAngle = Angle()
SWEP.IronsightsMuzzleParticle = true
SWEP.IronsightsMuzzleFlash = "muzzleflash_smg"
SWEP.CenteredPos = Vector(-2.031, 1.22,  -4.58)
SWEP.CenteredAng = Angle(2.92, 2.509, 0)
SWEP.MuzzleFlashSize = 256
SWEP.MuzzleFlashBrightness = 0.5
SWEP.MuzzleFlashColor = Color(192, 192, 192)


SWEP.LoweredPos = Vector(5, -2.7, -2.2)
SWEP.LoweredAng = Angle(5, 18, 2)

function SWEP:QueueIdle()
end

function SWEP:CustomShootEffects()
end

sound.Add({
	name = "1",
	sound = "ar1/ar2_reload_rotate.wav",
	channel = CHAN_WEAPON,
	level = 70,
	pitch = {95,105}
})

sound.Add({
	name = "0",
	sound = "weapons/eblaster_screw_in_0"..math.random(1, 5)..".wav",
	channel = CHAN_AUTO,
	level = 70,
	pitch = {95,105}
})