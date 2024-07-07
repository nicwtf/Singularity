-- "addons\\plutonic\\lua\\weapons\\plutonic_m1911.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "M1911"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "revolver"

SWEP.WorldModel = Model("models/weapons/arccw/w_cw_1911.mdl")
SWEP.ViewModel = Model("models/weapons/v_1911_bocw.mdl")
SWEP.ViewModelFOV = 88
SWEP.ViewModelOffset = Vector(0, 0, -0)
SWEP.ViewModelOffsetAng = Angle(0, 0, 0 )
SWEP.CenteredPos = Vector(-1.5,0,0)
SWEP.CenteredAng = Angle(0, 0, 0)

SWEP.BarrelLength = 5.03
SWEP.CrouchPos = nil
SWEP.CrouchAng = nil

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

sound.Add({
	name = "Weapon_M1911.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = "weapons/tfa_nam_1911/m1911_fp.wav"
})

SWEP.ReloadAttach = 2

SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")
SWEP.DoEmptyReloadAnim = true

SWEP.Primary.Sound = Sound("Weapon_M1911.Single")
SWEP.Primary.Sound_World = Sound("Weapon_Pistol.NPC_Fire")

SWEP.Primary.Recoil = 0.7 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 11.65
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = Plutonic.FireRate.RPM(380)
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 7

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.SwayLevel = 2
SWEP.SwayIdle = 0.4
SWEP.SwayBob = 2.6
SWEP.SwayRightMultiplier = 2.6
SWEP.SwayUpMultiplier = 2.6

SWEP.Spread = {}
SWEP.Spread.Min = 0.0001
SWEP.Spread.Max = 0.5
SWEP.Spread.IronsightsMod = 0.5 -- multiply
SWEP.Spread.CrouchMod = 0.5 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.017 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 1.025 -- movement speed effect on spread (additonal)
SWEP.IronsightsSpeed =nil
SWEP.IronsightsPos = Vector(-1.32, -5, 3)
SWEP.IronsightsAng =Angle(0, 0, 11.75)
SWEP.IronsightsFOV = 1
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRocking = 24
SWEP.IronsightsRecoilVisualMultiplier = 1
SWEP.BlowbackPos         = Vector(0.0, -5, -0.2) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0.6, -0, 0)
SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.MuzzleFlashAttachment = "1"

SWEP.CustomEvents = {
}

sound.Add({
	name = "1911.magout",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound = "weapons/tfa_nam_1911/m1911_magout.wav"
})

sound.Add({
	name = "1911.magin",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound = "weapons/tfa_nam_1911/m1911_magin.wav"
})

sound.Add({
	name = "1911.slideback",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound = "weapons/arccw/mag7/mag7_pump_back.wav"
})

sound.Add({
	name = "1911.slideforward",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = {95, 105},
	sound = "weapons/arccw/mag7/mag7_pump_forward.wav"
})

function SWEP:QueueIdle()
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)
	SWEP.OverrideWMEntity = WorldModel

	-- Settings...
	WorldModel:SetNoDraw(true)

	function SWEP:GetShootSrc()
		 local owner = self:GetOwner()

    	if !IsValid(owner) then return self:GetPos() end
    	if owner:IsNPC() then return owner:GetShootPos() end

    	local dir    = owner:EyeAngles()
    	local offset = Vector(0, 0, 0)

   		local src = owner:EyePos()


    	src = src + dir:Right()   * offset[1]
    	src = src + dir:Forward() * offset[2]
    	src = src + dir:Up()      * offset[3]

		self:DrawWorldModel() -- THIS WILL SET THE RIGHT POS FOR EFFECT

    	return src
	end

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			-- Specify a good position
			local offsetVec = Vector(3, -1, -5)
			local offsetAng = Angle( 0,-3,180)

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
SWEP.Attachments = {}