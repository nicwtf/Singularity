-- "addons\\plutonic\\lua\\weapons\\plutonic_pulsepistol.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base" 

SWEP.PrintName = "Pulse Pistol"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/ez2/c_pulsepistol.mdl"
SWEP.Attachments = {}
SWEP.WorldModel = "models/weapons/w_pulsepistol.mdl"
SWEP.ViewModelFOV = 55

sound.Add({
	name="PulsePistol.Single",
	sound={
		"weapons/ez2/pulsepistol/pistol_fire3.wav"
	},
	channel=CHAN_STATIC,
	pitch = {95, 105},
	volume = {0.95, 1},
	level = 143
})

sound.Add({
	name="PulsePistol.Charge",
	sound={
		"weapons/ez2/pulsepistol/pulse_pistol_charging.wav"
	},
	channel=CHAN_STATIC,
	pitch = {95, 105},
	volume = {0.95, 1},
	level = 143
})


SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("PulsePistol.Charge")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")
SWEP.Primary.Sound = Sound("PulsePistol.Single")
SWEP.Primary.Recoil = .5 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 11
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02
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

SWEP.IronsightsPos = Vector(-3.56, 10, 3.06)
SWEP.IronsightsAng = Angle(0, 0, 5)
SWEP.IronsightsFOV = .67
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2
SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.BlowbackPos = Vector(0, -2, -.142)

SWEP.LoweredPos = Vector(0, -16, -13)
SWEP.LoweredAng = Angle(55, 0, 0)
SWEP.IronsightsFireActivity = "ACT_VM_PRIMARYATTACK"

function SWEP:QueueIdle()
end

function SWEP:CustomShootEffects()
end


sound.Add({
	name = "TFA_MMOD.USP.Draw",
	sound = "weapons/projectmmod_pistol/pistoldeploy.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

sound.Add({
	name = "TFA_MMOD.USP.SlideRelease",
	sound = "weapons/projectmmod_pistol/pistolslideforward.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

sound.Add({
	name = "TFA_MMOD.USP.Magin",
	sound = "weapons/projectmmod_pistol/pistolslideforward.wav",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105}
})

-- TFA_MMOD.USP.SlideRelease
SWEP.CustomEvents = {
	[ACT_VM_DRAW] = ACT_VM_DRAW
}

SWEP.Offset = {
	Pos = {
	Up = -5.7,
	Right = 1,
	Forward = 1.7,
	},
	Ang = {
	Up = 0,
	Right = -9,
	Forward = 180,
	},
	Scale = 1.0
}

SWEP.BlowbackPos         = Vector(0.0, -2, -0.01) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0.0, -0, 0)

SWEP.DoEmptyReloadAnim = true

--[[
	function SWEP:ShootEffects()
	if self.UseIronsightsRecoil then
		self:PlayAnim(ACT_VM_PRIMARYATTACK)
		self:QueueIdle()
	else
		self:SetIronsightsRecoil( math.Clamp( 7.5 * (self.IronsightsRecoilVisualMultiplier or 1) * self.Primary.Recoil, 0, 20 ) )
	end
end
]]--

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

function SWEP:CustomShootEffects()
	self:PlayAnim(ACT_VM_PRIMARYATTACK)
end