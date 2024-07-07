-- "addons\\plutonic\\lua\\weapons\\plutonic_pewpew.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "Pew Pew"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "revolver"

SWEP.WorldModel = Model("models/weapons/w_pistol.mdl")
SWEP.Attachments = {}
SWEP.ViewModel = Model("models/weapons/c_pistol.mdl")
SWEP.CustomMaterial = "models/props_lab/Tank_Glass001"
SWEP.ViewModelFOV = 55

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_M4A1.Silenced")
SWEP.Primary.Recoil = 0.6 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 9999
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.018
SWEP.Primary.Delay = 1
SWEP.Primary.Tracer = "AR2Tracer"

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 18
SWEP.Primary.DefaultClip = 18

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.SwayLevel = 2
SWEP.SwayIdle = 1
SWEP.SwayBob = 2
SWEP.SwayRightMultiplier = 3.4
SWEP.SwayUpMultiplier = 4.4
SWEP.Spread = {}
SWEP.Spread.Min = 0.008
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.9 -- multiply
SWEP.Spread.CrouchMod = 1 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 1.025 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-6.035, 0, 3.029)
SWEP.IronsightsAng = Angle(0.2, -1.3, 1)
SWEP.IronsightsFOV = 0.75
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2
SWEP.MuzzleEffect = "muzzleflash_pistol"

SWEP.BlowbackPos         = Vector(0.0, -2, -1.1) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(3, -0, 0)