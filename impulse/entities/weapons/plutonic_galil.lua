-- "addons\\plutonic\\lua\\weapons\\plutonic_galil.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base" 

SWEP.PrintName = "IMI Galil"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"
SWEP.Enum = {}
SWEP.Enum.WeaponType = Plutonic.Enum.WeaponType.SubmachineGun

SWEP.Attachments = {}
SWEP.WorldModel = Model("models/weapons/w_bocw_galil.mdl")
SWEP.ViewModel = Model("models/weapons/v_bocw_galil.mdl")
SWEP.ViewModelFOV = 55

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("weapons/tfa_inss/galil/galil_empty.wav")

sound.Add({
	name = "Weapon_SMG.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = {
		"weapons/tfa_inss/galil/galil_fp.wav",
	}
})

SWEP.Primary.Sound = Sound("weapons/tfa_inss/galil/galil_fp.wav")
SWEP.Primary.Recoil = 0. -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 6.74
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.05
SWEP.Primary.Delay = 0.03

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 35
SWEP.Primary.DefaultClip = 45

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.3
SWEP.Spread.IronsightsMod = 0.3 -- multiply
SWEP.Spread.CrouchMod = 0.6 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.3 -- movement speed effect on spread (additonal)

SWEP.SwayLevel = 1
SWEP.SwayIdle = 0.8
SWEP.SwayRightMultiplier = 3.5
SWEP.SwayUpMultiplier = 3.4

SWEP.IronsightsRocking = 2
SWEP.IronsightsSpeed = 3
SWEP.IronsightsPos = Vector(-2.75, 0, 0.25)
SWEP.IronsightsAng = Angle(0.0, 0.0, 0)
SWEP.IronsightsFOV = .9
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 3.55
SWEP.UseIronsightsRecoil = true
SWEP.BlowbackPos         = Vector(0, -1, -0.1) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0, 0, 0)

SWEP.MuzzleEffect = "muzzleflash_smg"

--SWEP.LoweredPos = Vector(-2.814, -0.1, 0.201)
--SWEP.LoweredAng = Angle(-5.628, 20.402, 0)

SWEP.VLowered = false
SWEP.VTime = CurTime()
SWEP.DrawTime = 0
SWEP.HasLoweredActivity = false
function SWEP:CustomShootEffects()
	self.VTime = CurTime() + 0.1
	self.VLowered = false
end
SWEP.HasPlayedIntro = false
function SWEP:Deploy()
	self.BaseClass.Deploy(self)
end


function SWEP:CustomThink()
end
function SWEP:QueueIdle()
end