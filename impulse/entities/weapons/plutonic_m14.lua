-- "addons\\plutonic\\lua\\weapons\\plutonic_m14.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "M14"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_bocw_m14.mdl")
SWEP.ViewModel = Model("models/weapons/v_m14_bocw.mdl")
SWEP.Attachments = {}
SWEP.ViewModelFOV = 74
SWEP.ViewModelOffset = Vector(-0.403,1,-1)

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.EmptySound = Sound("Weapon_Mini14.Empty")

SWEP.Primary.Sound = Sound("Weapon_Mini14.Single")
SWEP.Primary.Recoil = 0.32-- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 15.32
SWEP.Primary.PenetrationScale = 0.5
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.029
SWEP.Primary.Delay = Plutonic.FireRate.RPM(415)
SWEP.Primary.Piercing = true	

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.3
SWEP.Spread.IronsightsMod = 0.6 -- multiply
SWEP.Spread.CrouchMod = 0.6 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.0932 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.17 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-4.197, -0, 2.15)
SWEP.IronsightsAng = Angle(-0.2,0,0)
SWEP.IronsightsFOV = 0.75
SWEP.IronsightsSensitivity = 0.5
SWEP.IronsightsCrosshair = false
SWEP.BlowbackPos = Vector(0, -4, -0.1)
SWEP.BlowbackAngle = Angle(0, -0, 0)
SWEP.DoEmptyReloadAnim = true

SWEP.MuzzleEffect = "muzzleflash_m14"
SWEP.MuzzleFlashAttachment = "1"
SWEP.ReloadAttach = 2
SWEP.Reverb = {}
SWEP.Reverb.Primary = {}

SWEP.Reverb.Primary.IndoorEnabled = true
SWEP.Reverb.Primary.Indoor = Sound("weapons/mni14/mini14_indoor_distant.wav")
SWEP.Reverb.Primary.IndoorRange = 5000

SWEP.Reverb.Primary.OutdoorEnabled = true
SWEP.Reverb.Primary.Outdoor = Sound("weapons/mni14/mini14_outdoor_distant.wav")
SWEP.Reverb.Primary.OutdoorRange = 5000

local copyIronFOV = SWEP.IronsightsFOV + 0
local copyIronSens = SWEP.IronsightsSensitivity + 0
local copyCone = SWEP.Primary.Cone + 0
local copyIronMod = SWEP.Spread.IronsightsMod + 0
local copyVelMod = SWEP.Spread.VelocityMod + 0
local copyDamage = SWEP.Primary.Damage + 0
local copyRPM = SWEP.Primary.Delay + 0
local copyPen = SWEP.Primary.PenetrationScale + 0
SWEP.Attachments = {
	hunting_scope = {
		Cosmetic = {
			Model = "models/weapons/tfa_ins2/upgrades/a_optic_m40_test.mdl",
			Bone = "mini_14",
			Pos = Vector(5.099, -4, -0.9),
			Ang = Angle(0, 77.5, 0),
			Scale = 0.85,
			Skin = 0,
			World = {
				Pos = Vector(11, -0.4, -6.1),
				Ang = Angle(-2, -2, 90),
				Scale = 0.85
			}
		},
		ModSetup = function(e)
			e.IronsightsFOV = 0.65
			e.FOVScoped = 0.3
			e.IronsightsSensitivity = 0.18

			e.Primary.Cone = 0.035
			e.Spread.IronsightsMod = 0.09
			e.Spread.VelocityMod = 0.4

			e.NoCrosshair = true
			e.NoThirdpersonIronsights = true
		end,
		ModCleanup = function(e)
			e.IronsightsFOV = copyIronFOV
			e.FOVScoped = nil
			e.IronsightsSensitivity = copyIronSens

			e.Primary.Cone = copyCone
			e.Spread.IronsightsMod = copyIronMod
			e.Spread.VelocityMod = copyVelMod

			e.NoCrosshair = false
			e.NoThirdpersonIronsights = false
		end,
		Behaviour = "sniper_sight",
		NeedsHDR = true,
		ScopeTexture = Material("ph_scope/ph_scope_lens3")
	}
}

SWEP.LoweredPos = Vector(7,-6,-0) --Vector(0, -16, -13)
SWEP.LoweredAng = Angle(-2, 55, 0)

sound.Add({
	name = "Weapon_Mini14.Single",
	sound = "weapons/cw_m14/m14_wz.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_danger_mini14_rifle.Magin",
	sound = "weapons/mni14/mini14_magin.wav",
	channel = CHAN_WEAPON,
	level = 70,
	pitch = {95,105}
})

sound.Add({
	name = "Weapon_danger_mini14_rifle.Magout",
	sound = "weapons/mni14/mini14_magout.wav",
	channel = CHAN_WEAPON,
	pitch = {95,105}
})

sound.Add({
	name = "Weapon_danger_mini14_rifle.rattle",
	sound = "weapons/mni14/galil_rattle.wav",
	channel = CHAN_WEAPON,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_danger_mini14_rifle.bolt",
	sound = "weapons/mni14/mini14_boltback.wav",
	channel = CHAN_WEAPON,
	pitch = {95, 105}
})

sound.Add({
	name = "Weapon_danger_mini14_rifle.bolt2",
	sound = "weapons/mni14/mini14_boltrelease.wav",
	channel = CHAN_WEAPON,
	pitch = {95, 105}
})


sound.Add({
	name = "Weapon_Mini14.Empty",
	sound = "weapons/mni14/mini14_empty.wav",
	channel = CHAN_WEAPON,
	pitch = {95,105}
})


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


function SWEP:CustomShootEffects()
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	-- Settings...
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			-- Specify a good position
			local offsetVec = Vector(1, -1.7, -5.7)
			local offsetAng = Angle(0, 9, 180)

			local boneid = _Owner:LookupBone( "ValveBiped.Bip01_R_Hand" ) -- Right Hand
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local hMatrix = Matrix()
			
			hMatrix:SetAngles(offsetAng)

			matrix:Translate(offsetVec)
			matrix:Rotate(offsetAng)

			WorldModel:SetPos(matrix:GetTranslation())
			WorldModel:SetAngles(matrix:GetAngles())

			WorldModel:SetupBones()
		else
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
		end

		WorldModel:DrawModel()
	end
end

local path = "weapons/cw_m14/"
local pref = "dmr14"
local hudcolor = Color(255, 255, 255, 255)