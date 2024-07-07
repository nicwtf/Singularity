-- "addons\\plutonic\\lua\\weapons\\plutonic_ak47.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

hook.Add("Initialize","LandisRifleAmmo",function()
	game.AddAmmoType({
		name = "Rifle",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE_AND_WHIZ,
		force = 1000,
		minsplash = 10,
		maxsplash = 100
	})
end)

SWEP.Base = "plutonic_base"
SWEP.Attachments = {}

SWEP.PrintName = "AK-47"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_akm_inss.mdl")
SWEP.ViewModel = Model("models/horizons_weapons/akm/c_akm.mdl")
SWEP.ViewModelFOV = 64
SWEP.ViewModelOffset = Vector(0.622,1,-0.422)

SWEP.Enum = {}
SWEP.Enum.WeaponType = Plutonic.Enum.WeaponType.AutomaticRifle
SWEP.Enum.BarrelLength = Plutonic.Enum.BarrelLength.Custom(16.5)

SWEP.SwayLevel = 0.32
SWEP.SwayRightMultiplier = .5
SWEP.SwayUpMultiplier = .5
SWEP.SwayIdle = 1
SWEP.SwayBob = 1

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("weapon/akm/akm_fire_player_0"..math.random(1,9)..".wav")
SWEP.Primary.Recoil = .34 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.MaxRecoil = 2.1
SWEP.Primary.RecoilRecoveryRate = 4.5
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.030
SWEP.Primary.Delay = Plutonic.FireRate.RPM(800)

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 2
SWEP.Spread.IronsightsMod = 0.55 -- multiply
SWEP.Spread.CrouchMod = 0.75 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.7 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.009 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.RecoilAcceleration = 1
SWEP.Spread.VelocityMod = 0.2 -- movement speed effect on spread (additonal)
SWEP.IronsightsPos = Vector(-4., -0, 1.891)
SWEP.IronsightsAng = Angle(0.28, 0, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1

SWEP.BlowbackPos = Vector(0, -6, -0.15)
SWEP.BlowbackAngle = Angle(0.5, -0, 0)

SWEP.Reverb = {}
SWEP.Reverb.Primary = {}

local ShootAnims = {
	"shoot1",
	"shoot2",
	"shoot3"
}

SWEP.PrimaryFireSequence = "shoot2"

SWEP.MuzzleEffect = "muzzleflash_3"
SWEP.MuzzleFlashAttachment = "muzzle"

SWEP.LoweredPos = Vector(2.119,.4,1.1)
SWEP.LoweredAng = Angle(-12.7, 29.7, -5.9)

SWEP.LowerAngles = Angle(23, -9, -2.4)
SWEP.LowerPos = Vector(-2, -8.6, -3)

sound.Add({
	name = "Weapon_iAK47.Single",
	sound = "impulse/ak47_fire.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})


sound.Add({
	name = "Weapon_i2AK47.Single",
	sound = "horizons_weapons/ak47/ak47-single.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})