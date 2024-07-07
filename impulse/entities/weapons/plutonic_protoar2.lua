-- "addons\\plutonic\\lua\\weapons\\plutonic_protoar2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "Prototype AR2"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.Attachments = {}
SWEP.WorldModel = Model("models/weapons/w_irifle.mdl")
SWEP.ViewModel = Model("models/weapons/ez2/c_ar2_proto.mdl")
-- 2160286637
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("Weapon_AR2.Empty")

SWEP.Primary.Sound = Sound("proto_ar2/fire1.wav")
SWEP.Primary.Recoil = 0.23 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 16.86
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.0348 -- base spread value
SWEP.Primary.Delay = 0.08
SWEP.Primary.Tracer = "AR2Tracer"

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 45
SWEP.Primary.DefaultClip = 45

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