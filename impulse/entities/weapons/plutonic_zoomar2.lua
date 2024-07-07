-- "addons\\plutonic\\lua\\weapons\\plutonic_zoomar2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "AR2 (Zoom)"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_irifle.mdl")
SWEP.ViewModel = Model("models/weapons/ez2/c_ar2.mdl")
SWEP.Attachments = {}
-- 2160286637
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("ar2_reload1.wav")
SWEP.EmptySound = Sound("Weapon_AR2.Empty")

SWEP.Primary.Sound = Sound("ar2/fire1.wav")

SWEP.Primary.Recoil = 0.4 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 16.84
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02 -- base spread value
SWEP.Primary.Delay = RPM(725)
SWEP.Primary.Tracer = "AR2Tracer"
SWEP.Primary.Piercing = true

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.7 -- multiply
SWEP.Spread.CrouchMod = 0.7 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.4 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.1 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.16 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-2.1, 0, 2.05)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.7
SWEP.IronsightsSensitivity = 0.7
SWEP.IronsightsCrosshair = true
SWEP.IronsightsRecoilVisualMultiplier = 4
SWEP.CannotChamber = true
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
SWEP.MuzzleEffect = "muzzleflash_1"

SWEP.LoweredPos = Vector(5.119, -1.921, -0.24)
SWEP.LoweredAng = Angle(-5.7, 29.7, -1.9)

SWEP.LowerAngles = Angle(23, -9, -2.4)
SWEP.LowerPos = Vector(-2, -8.6, -3)

sound.Add( {
	name = 'Weapon_AR2.EZ2RStart',
	channel = CHAN_STATIC,
	volume = 1,
	level = 64,
	pitch = { 0, 1 },
	sound = 'weapons/ar2/ar2_rotate.wav'
} )
sound.Add( {
	name = 'Weapon_AR2.EZ2REnd',
	channel = CHAN_STATIC,
	volume = 1,
	level = 64,
	pitch = { 0, 1 },
	sound = 'weapons/ar2/ar2_reload_rotate.wav'
} )

sound.Add({
	name = "ardistance",
	sound = {
		"weapons/hlvr/irifle/wpn_combine_ar_fire_tail_01.wav",
		"weapons/hlvr/irifle/wpn_combine_ar_fire_tail_02.wav",
		"weapons/hlvr/irifle/wpn_combine_ar_fire_tail_03.wav",
		"weapons/hlvr/irifle/wpn_combine_ar_fire_tail_04.wav"
	},
	channel = CHAN_WEAPON,
	pitch = {95, 105}
})

util.PrecacheSound("ardistance")

SWEP.Reverb = {}
SWEP.Reverb.Primary = {}

SWEP.Reverb.Primary.IndoorEnabled = true
SWEP.Reverb.Primary.Indoor = Sound("weapons/hlvr/irifle/wpn_combine_ar_fire_tail_02.wav")
SWEP.Reverb.Primary.IndoorRange = 5000

SWEP.Reverb.Primary.OutdoorEnabled = true
SWEP.Reverb.Primary.Outdoor = Sound("weapons/hlvr/irifle/wpn_combine_ar_fire_tail_02.wav")
SWEP.Reverb.Primary.OutdoorRange = 5000