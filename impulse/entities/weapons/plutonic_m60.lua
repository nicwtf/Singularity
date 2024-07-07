-- "addons\\plutonic\\lua\\weapons\\plutonic_m60.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "M60"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/kali/weapons/m60.mdl")
SWEP.ViewModel = Model("models/weapons/v_dm60.mdl")
SWEP.ViewModelFOV = 56
SWEP.Attachments = {}

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.Enum = {}
SWEP.Enum.WeaponType = Plutonic.Enum.WeaponType.AutomaticRifle
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_M249.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_M60.Single")
SWEP.Primary.Recoil = 0.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 10
SWEP.Primary.PenetrationScale = 1.8
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.06
SWEP.Primary.Delay = Plutonic.FireRate.RPM(675)

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.SwayRightMultiplier = 5

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.65 -- multiply
SWEP.Spread.CrouchMod = 0.35 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.8 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.1 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.8 -- movement speed effect on spread (additonal)
SWEP.SwayLevel = 0.15
SWEP.SwayBob = 2
SWEP.IronsightsRocking = 30
SWEP.IronsightsSpeed = 3
SWEP.IronsightsPos = Vector(-6.111, 0, 1.34)
SWEP.IronsightsAng = Angle(-2.401, -0.102, -1)
SWEP.IronsightsFOV = 0.72
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 3.5
SWEP.BlowbackPos         = Vector(00, -1, -0.1) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0.2, -0, 0)

SWEP.IronsightsMuzzleParticle = true
SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.MuzzleFlashAttachment = "1"

SWEP.LoweredPos = Vector(0, -16, -13)
SWEP.LoweredAng = Angle(45, 0, 0)

sound.Add({
	name = "Weapon_M60.Single",
	sound = {
		"weapon/hmg/hmg_fire_player_01.wav",
		"weapon/hmg/hmg_fire_player_02.wav",
		"weapon/hmg/hmg_fire_player_03.wav",
		"weapon/hmg/hmg_fire_player_04.wav",
		"weapon/hmg/hmg_fire_player_05.wav",
		"weapon/hmg/hmg_fire_player_06.wav",
		"weapon/hmg/hmg_fire_player_07.wav",
		"weapon/hmg/hmg_fire_player_08.wav",
		"weapon/hmg/hmg_fire_player_09.wav",
		"weapon/hmg/hmg_fire_player_10.wav",
		"weapon/hmg/hmg_fire_player_11.wav",
		"weapon/hmg/hmg_fire_player_12.wav"	
	},
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})