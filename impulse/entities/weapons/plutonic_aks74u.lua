-- "addons\\plutonic\\lua\\weapons\\plutonic_aks74u.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "Aks74u"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Attachments = {}
SWEP.HoldType = "ar2"

SWEP.WorldModel = Model( "models/weapons/aks74u/w_aks74u.mdl")
SWEP.ViewModel = Model( "models/weapons/aks74u/c_aks74u.mdl")
SWEP.ViewModelFOV = 75
SWEP.ViewModelOffset = Vector(0,0,0)
SWEP.BarrelLength = 12
SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("Weapon_Mini14.Empty")

sound.Add({
	name = "Weapon_Aks.Fire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 140,
	pitch = {95, 105},
	sound = "weapons/aks74u/aks74u_shoot.ogg"
})

function SWEP:CustomThink()
	if not self:HasAttachment("mag") then
		if CLIENT then return end
		self:GiveAttachment("mag")
	end
end
SWEP.Primary.Sound = Sound("Weapon_Aks.Fire")
SWEP.Primary.Recoil = 0.55 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 10.2
SWEP.Primary.PenetrationScale = 1.1
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.025
SWEP.Primary.Delay = 0.03
SWEP.Primary.Piercing = true

SWEP.Primary.RecoilUp = .1
SWEP.Primary.RecoilDown = .1
SWEP.Primary.RecoilSide = .1


SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0.00
SWEP.Spread.Max = 1
SWEP.Spread.IronsightsMod = 0.5 -- multiply
SWEP.Spread.CrouchMod = 0.5 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 1.025 -- movement speed effect on spread (additonal)

SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.5
SWEP.IronsightsCrosshair = false
SWEP.BlowbackPos = Vector(0, -2, -0.1)
SWEP.BlowbackAngle = Angle(0, -0, 0)
SWEP.DoEmptyReloadAnim = true
SWEP.CenteredPos = Vector(-2.631,1.22,  -4.58)
SWEP.CenteredAng = Angle(2.92, 2.509, -17.216)
SWEP.MuzzleEffect = "muzzleflash_6"
SWEP.MuzzleFlashAttachment = "muzzle"
SWEP.ReloadAttach = 2
SWEP.Reverb = {}
SWEP.Reverb.Primary = {}

SWEP.LoweredPos = Vector(0, 0, -1.2)
SWEP.LoweredAng = Angle(-8.3, 14.8, -25.5)
SWEP.LoweredMidPos = Vector(0,-2,0.4)
SWEP.LoweredMidAng = Angle(4,8,20)
SWEP.IronsightsPos = Vector(-2.467, -1, 1.24)
SWEP.IronsightsAng = Angle(0.1, 0, 0)
