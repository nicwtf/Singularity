-- "addons\\plutonic\\lua\\weapons\\plutonic_purplesmokegrenade.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base_projectile"

SWEP.PrintName = "Purple Smoke Grenade"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "grenade"

SWEP.WorldModel = Model("models/weapons/w_eq_smokegrenade.mdl")
SWEP.ViewModel = Model("models/weapons/cstrike/c_eq_smokegrenade.mdl")
SWEP.ViewModelFOV = 64

SWEP.Slot = 4
SWEP.Attachments = {}
SWEP.SlotPos = 1
SWEP.SwayLevel = 3
SWEP.SwayIdle = 3
SWEP.SwayBob = 3.3

SWEP.SwayRightMultiplier = 3
SWEP.SwayUpMultiplier = 3
SWEP.Primary.Sound = ""
SWEP.Primary.Recoil = 0 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Delay = 0.8
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = "gas"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Damage = 5
SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/weapons/w_eq_smokegrenade_thrown.mdl")
SWEP.Projectile.FireSound = Sound("weapons/smokegrenade/sg_explode.wav")
SWEP.Projectile.HitSound = Sound("weapons/smokegrenade/grenade_hit1.wav")
SWEP.Projectile.Touch = false
SWEP.Projectile.ForceMod = 1.2
SWEP.Projectile.Timer = 5
SWEP.Projectile.RemoveWait = 50
SWEP.IsAlwaysRaised = true
sound.Add({
	name = "Weapon_TearGas.Hiss",
	sound = "npc/env_headcrabcanister/hiss.wav",
	level = 56,
	pitch = 110
})

function SWEP:ProjectileFire()
	local sfx = EffectData()
	sfx:SetEntity(self)
	sfx:SetOrigin(self:GetPos())
	
	util.Effect("smokepurple", sfx, nil, true)

	self:EmitSound("Weapon_TearGas.Hiss")
end

function SWEP:ProjectileRemove()
	self:StopSound("Weapon_TearGas.Hiss")
end

local range = 250 ^ 2
function SWEP:ProjectileThink()
	if self.NextDamageCheck and self.NextDamageCheck < CurTime() then
		return
	end
end