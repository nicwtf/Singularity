-- "addons\\plutonic\\lua\\weapons\\plutonic_usp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base" 

SWEP.PrintName = "USP Match"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/ez2/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ViewModelFOV = 55
SWEP.Attachments = {}

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

sound.Add({
	name = "CUST.Weapn_USP.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = {
		"weapon/alyxgun/alyxgun_fire_player_01.wav",
        "weapon/alyxgun/alyxgun_fire_player_02.wav",
        "weapon/alyxgun/alyxgun_fire_player_03.wav",
        "weapon/alyxgun/alyxgun_fire_player_04.wav",
        "weapon/alyxgun/alyxgun_fire_player_05.wav",
        "weapon/alyxgun/alyxgun_fire_player_06.wav"
	}
})

sound.Add({
	name = "USP.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = {
		"pm_indoor_close2.wav"
	}
})

SWEP.ReloadSound = Sound("weapons/madcop/pistol/pistol_reload1.wav")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")
SWEP.Primary.Sound = Sound("CUST.Weapn_USP.Single")
SWEP.Primary.Sound_World = Sound("CUST.Weapn_USP.Single")
SWEP.Primary.Recoil = .5 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 8.5
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.048
SWEP.Primary.Delay = 0.03

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 18
SWEP.Primary.DefaultClip = 18

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.4 -- multiply
SWEP.Spread.CrouchMod = 0.9 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 1.3 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-3.71, 10, 2.58)
SWEP.IronsightsAng = Angle(0, 0, 5)
SWEP.IronsightsFOV = .67
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.MuzzleFlashAttachment = "muzzle"
SWEP.BlowbackPos = Vector(0.0, -2, -0.01) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle = Angle(0.0, -0, 0)

SWEP.LowerPos = Vector(0,-13,-2)
SWEP.LowerAngles = Angle(23, -0, 0)

function SWEP:QueueIdle()
end

function SWEP:CustomShootEffects()
	self:PlayAnim(ACT_VM_PRIMARYATTACK)
end