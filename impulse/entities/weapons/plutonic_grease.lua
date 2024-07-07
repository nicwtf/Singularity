-- "addons\\plutonic\\lua\\weapons\\plutonic_grease.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
hook.Add("Initialize","Landis45Ammo",function()
	game.AddAmmoType({
		name = "45",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE_AND_WHIZ,
		force = 1000,
		minsplash = 10,
		maxsplash = 100
	})
end)
SWEP.Base = "plutonic_base"

SWEP.ItemClass = "wep_grease"
SWEP.PrintName = "M3 Grease"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Enum = {}
SWEP.Enum.WeaponType = Plutonic.Enum.WeaponType.SubmachineGun

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/weapons/boyz/w_m3.mdl")
SWEP.ViewModel = Model("models/weapons/boyz/c_m3.mdl")
SWEP.ViewModelFOV = 75
SWEP.ViewModelOffset = Vector(0, 0, 0)
SWEP.ViewModelOffsetAng = Angle(0, 0, 0)

SWEP.BarrelLength = 9

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_greasegun.Single")
SWEP.Primary.Recoil = 0.5 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.0321
SWEP.Primary.Delay = Plutonic.FireRate.RPM(410)

SWEP.Primary.PenetrationScale = 0.85

SWEP.Primary.StartFalloff = 800
SWEP.Primary.EndFalloff = 2000

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.51
SWEP.Spread.IronsightsMod = 0.7 -- multiply
SWEP.Spread.CrouchMod = 0.8 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.3 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.42 -- movement speed effect on spread (additonal)

SWEP.SwayLevel = 1
SWEP.SwayBob = 2.4
SWEP.SwayIdle = 0.4
SWEP.IronsightsRocking = 24
SWEP.SwayRightMultiplier = 2.7
SWEP.SwayUpMultiplier = 2.7

SWEP.IronsightsPos = Vector(-2.5, -1.5, 1.35)
SWEP.IronsightsAng = Angle(0, 0, 5.998)

SWEP.CenteredPos = Vector(-2.25, -1,-1.279)
SWEP.CenteredAng = Angle(0, 0, 5.998)

SWEP.IronsightsFOV = .95
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1
SWEP.BlowbackPos         = Vector(00, -2, -0.1) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0.0, -0, 0)

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.MuzzleFlashAttachment = "1"

SWEP.ReloadAttach = 2


local lerpSpeed = 1

-- General math caching
local abs,
	min,
	max,
	clamp,
	sin,
	cos,
	rad,
	deg,
	pi,
	pi2,
	round,
	Curtime,
	Frametime,
	Realtime,
	vec,
	ang,
	lerp,
	lerpAngle,
	lerpVector,
	approach =

	math.abs,
	math.min,
	math.max,
	math.Clamp,
	math.sin,
	math.cos,
	math.rad,
	math.deg,
	math.pi,
	math.pi * 2,
	math.Round,
	CurTime,
	FrameTime,
	RealTime,
	Vector,
	Angle,
	Lerp,
	LerpAngle,
	LerpVector,
	math.Approach

SWEP.CustomBob = false

SWEP.Attachments = {
	def = {
		Cosmetic = {
			Model = "models/weapons/boyz/upgrade/sight_m3.mdl",
			Bone = "Weapon",
			Pos = Vector(-3.31, 2.335, -14.839),
			Ang = Angle(90, 0, 90),
			Scale = 1.085
		},
		ModSetup = function(e)
			
		end,
		ModCleanup = function(e)
			
		end,
		Behaviour = "dumy"
	}
}

function SWEP:CustomThink()
	if not self:HasAttachment("def") then
		self:GiveAttachment("def")
	end
end

sound.Add({
	name = "Weapon_greasegun.Single",
	sound = "weapons/m3_boyz/fire.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_greasegun.Magin",
	sound = "weapons/m3_boyz/magin.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_greasegun.Magout",
	sound = "weapons/m3_boyz/magout.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_greasegun.Magrelease",
	sound = "weapons/m3_boyz/magrelease.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_greasegun.Maghit",
	sound = "weapons/m3_boyz/maghit.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_greasegun.BoltBack",
	sound = "weapons/m3_boyz/boltback.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_greasegun.Draw",
	sound = "weapons/m3_boyz/draw.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

SWEP.ReloadProceduralCameraFrac = .2

function SWEP:GetReloadAnimation(pos, ang)
	local vm = self.Owner:GetViewModel()

	local bone = "Magazine"

	local tag_view = vm:GetBonePosition(vm:LookupBone(bone))

	local view = (tag_view-pos):GetNormalized():Angle() 

	return view
end