-- "addons\\plutonic\\lua\\weapons\\plutonic_mp7.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "MP7A1"
SWEP.Category = "Plutonic: HL2RP Weapons"
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Enum = {}
SWEP.Enum.WeaponType = Plutonic.Enum.WeaponType.SubmachineGun

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/horizons_weapons/smg1/w_smg1.mdl")
SWEP.ViewModel = Model("models/horizons_weapons/smg1/c_smg1.mdl")
SWEP.ViewModelFOV = 62
SWEP.ViewModelOffset = Vector(-1, 0, 0)

SWEP.BarrelLength = 6.3
SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

sound.Add({
	name = "Weapon_SMG1.FireSound",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = {
		"weapon/smg1/smg1_fire_player_01.wav",
		-- create 1-12
		"weapon/smg1/smg1_fire_player_02.wav",
		"weapon/smg1/smg1_fire_player_03.wav",
		"weapon/smg1/smg1_fire_player_04.wav",
		"weapon/smg1/smg1_fire_player_05.wav",
		"weapon/smg1/smg1_fire_player_06.wav",
		"weapon/smg1/smg1_fire_player_07.wav",
		"weapon/smg1/smg1_fire_player_08.wav",
		"weapon/smg1/smg1_fire_player_09.wav",
		"weapon/smg1/smg1_fire_player_10.wav",
		"weapon/smg1/smg1_fire_player_11.wav",
		"weapon/smg1/smg1_fire_player_12.wav"
	}
})

SWEP.Primary.Sound =  Sound("Weapon_SMG1.FireSound")
SWEP.Primary.Sound_World = Sound("Weapon_SMG1.NPC_Fire")

SWEP.Primary.Recoil = 0.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.Delay = Plutonic.FireRate.RPM(840)
SWEP.Primary.Shell = "ShellEject"
SWEP.Primary.ShellScale = 1.5
SWEP.Primary.ShellAttachment = 2
SWEP.Primary.RecoilUp = 1
SWEP.Primary.RecoilDown = 1
SWEP.Primary.RecoilSide = 2.56
SWEP.Primary.HeadshotScale = 0.9
SWEP.CannotChamber = false

SWEP.Primary.StartFalloff = 1200
SWEP.Primary.FallOff = 1800

SWEP.Primary.PenetrationScale = 1.00

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 45
SWEP.Primary.DefaultClip = 45

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.4
SWEP.Spread.IronsightsMod = 0.95 -- multiply
SWEP.Spread.CrouchMod = 1 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.1 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.42 -- movement speed effect on spread (additonal)



SWEP.IronsightsPos = Vector(-5.5, -7, 0.625)
SWEP.IronsightsAng = Angle(0.472, 0.017, 0)
SWEP.IronsightsFOV = 1
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1
SWEP.BlowbackPos         = Vector(0, -2, -0.1) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0, 0, 0)

SWEP.CenteredPos = Vector(-5.5, -4, -1.65)
SWEP.CenteredAng = Angle(0.472, 0.017, 0)

SWEP.MuzzleEffect = "muzzleflash_smg"

--SWEP.LowerPos = Vector(2.72, 0, 0.6)
--SWEP.LowerAngles = Angle(-9.801, 23.6, -6.2)
SWEP.LowerPos = Vector(2.72, 0, 0.6)
SWEP.LowerAngles = Angle(-9.801, 23.6, -6.2)


SWEP.ReloadAttach = 3

sound.Add({
	name = "Weapon_SMG.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = "smg1/smg1_fire1.wav"
})

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

SWEP.ReloadProceduralCameraFrac = .21
function SWEP:GetReloadAnimation(pos, ang)
	local vm = self.Owner:GetViewModel()

	local bone = "magazine"

	local tag_view = vm:GetBonePosition(vm:LookupBone(bone))

	local view = (tag_view-pos):GetNormalized():Angle() 

	return view
end