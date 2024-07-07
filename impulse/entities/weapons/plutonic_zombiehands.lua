-- "addons\\plutonic\\lua\\weapons\\plutonic_zombiehands.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base_melee"

SWEP.PrintName = "Zombie Hands"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "fist"

SWEP.WorldModel = Model("")
SWEP.ViewModel = Model("models/weapons/hl2meleepack/v_brokenbottle.mdl")
SWEP.Attachments = {}
SWEP.ViewModelFOV = 80

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_Zombie.Primary")
SWEP.Primary.ImpactSound = Sound("Weapon_Zombie.Hit")
SWEP.Primary.Recoil = 3.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 15 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 1
SWEP.Primary.HitDelay = 0.4
SWEP.Primary.Range = 81
SWEP.Primary.StunTime = 0.8
SWEP.Primary.HullSize = 7

sound.Add({
	name = "Weapon_Zombie.Hit",
	sound = {"npc/zombie/claw_strike3.wav"}, {"npc/zombie/claw_strike2.wav"}, {"npc/zombie/claw_strike1.wav"},
	level = 60,
	channel = CHAN_AUTO,
	pitch = {90,110}
})

sound.Add({
	name = "Weapon_Zombie.Primary",
	sound = {"npc/zombie/zombie_alert1.wav"}, {"npc/zombie/zombie_alert2.wav"}, {"npc/zombie/zombie_alert3.wav"},
	level = 60,
	channel = CHAN_AUTO,
	pitch = {90,110}
})

