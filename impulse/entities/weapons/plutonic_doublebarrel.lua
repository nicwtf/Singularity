-- "addons\\plutonic\\lua\\weapons\\plutonic_doublebarrel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "Double Barrel Shotgun"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.WorldModel = Model("models/weapons/arccw/w_db.mdl")
SWEP.ViewModel = Model("models/weapons/arccw/c_db.mdl")
SWEP.Attachments = {}
SWEP.ViewModelFOV = 70
SWEP.CenteredPos = Vector(0,0,0)
SWEP.CenteredAng = Angle(0, 0, 0)

SWEP.BarrelLength = 15

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_DoubleBarrel.Single")
SWEP.Primary.Recoil = 11 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 8
SWEP.Primary.Cone = 0.05
SWEP.Primary.Delay = Plutonic.FireRate.RPM(200)
SWEP.CannotChamber = true
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 2
SWEP.Primary.StartFalloff = 200
SWEP.Primary.EndFalloff = 1000
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.DoEmptyReloadAnim = true
SWEP.ReloadWorldSound = Sound("Weapon_Shotgun.Reload")

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.86 -- multiply
SWEP.Spread.CrouchMod = 0.88 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.1 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.05 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-2.412, -3.217, 1.406)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.9
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector(7.4, -0.16, -4.961)
SWEP.LoweredAng = Angle(7.4, 30.7, 3.9)

SWEP.BlowbackPos         = Vector(0, -3, -0.4) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(3, 0, 0)

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.MuzzleFlashAttachment = "1"

SWEP.Reverb = {}
SWEP.Reverb.Primary = {}

SWEP.Reverb.Primary.IndoorEnabled = true
SWEP.Reverb.Primary.Indoor = Sound("weapons/700n-3_indoor_echo.wav")
SWEP.Reverb.Primary.IndoorRange = 5000

SWEP.Reverb.Primary.OutdoorEnabled = true
SWEP.Reverb.Primary.Outdoor = Sound("weapons/700n-3_outdoor_distant.wav")
SWEP.Reverb.Primary.OutdoorRange = 5000

sound.Add({
	name = "Weapon_DoubleBarrel.Single",
	sound = "weapons/700n-3.wav",
	channel = CHAN_AUTO,
	level = SNDLVL_GUNFIRE
})

sound.Add({
	name = "Weapon_danger_12ga.break",
	sound = "weapons/tfa_doublebarrel/breakopen.wav"
})

-- weapons/700n-close.wav

sound.Add({
	name = "Weapon_danger_12ga.load",
	sound = "weapons/tfa_doublebarrel/breakopen.wav"
})

--weapons/700n-eject.wav

sound.Add({
	name = "Weapon_danger_12ga.shellfall",
	sound = "weapons/tfa_doublebarrel/shellseject.wav"
})

-- weapons/700n-shell1.wav

sound.Add({
	name = "Weapon_danger_12ga.shell1",
	sound = "weapons/tfa_doublebarrel/shellinsert1.wav"
})

sound.Add({
	name = "Weapon_danger_12ga.shell2",
	sound = "weapons/tfa_doublebarrel/shellinsert2.wav"
})

SWEP.ReloadProceduralCameraFrac = .2

function SWEP:GetReloadAnimation(pos, ang)
	local vm = self.Owner:GetViewModel()

	local bone = "Weapon_Thing"

	local tag_view = vm:GetBonePosition(vm:LookupBone(bone))

	local view = (tag_view-pos):GetNormalized():Angle() 

	return view
end