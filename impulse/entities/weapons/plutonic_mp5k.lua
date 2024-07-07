-- "addons\\plutonic\\lua\\weapons\\plutonic_mp5k.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base"

SWEP.PrintName = "MP5K"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/horizons_weapons/mp5k/w_mp5k.mdl")
SWEP.ViewModel = Model("models/horizons_weapons/mp5k/c_mp5k.mdl")
SWEP.ViewModelFOV = 74
SWEP.ViewModelOffset = Vector(0,0,0)
SWEP.ViewModelOffsetAng = Angle(0, 0, 0)
SWEP.Enum = {}
SWEP.Enum.WeaponType = Plutonic.Enum.WeaponType.SubmachineGun
SWEP.BarrelLength = 5

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_SMG2.Fire")
SWEP.Primary.Sound_World = Sound("Weapon_SMG2.NPC_Fire")
SWEP.Primary.Recoil = 0.3 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 11
SWEP.Primary.NumShots = 1
SWEP.Primary.Burst = 3
SWEP.Primary.Cone = 0.023
SWEP.Primary.Delay = Plutonic.FireRate.RPM(1156)
SWEP.Primary.BurstEndDelay = 0.24
SWEP.Primary.Shell = "ShellEject"
SWEP.Primary.ShellScale = 1.5
SWEP.Primary.ShellAttachment = 2
SWEP.Primary.StartFalloff = 1200
SWEP.Primary.FallOff = 1800
SWEP.Primary.PenetrationScale = 0.6
SWEP.Primary.RecoilUp = 1
SWEP.Primary.RecoilDown = 1
SWEP.Primary.RecoilSide = 2.56

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.65 -- multiply
SWEP.Spread.CrouchMod = 0.65 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.42 -- movement speed effect on spread (additonal)
SWEP.IronsightsPos = Vector(-4.176, 1, 1.5)
SWEP.IronsightsAng = Angle(0.368, -0.197, 0)
SWEP.CenteredPos = Vector( -3.417, -2.226,-4.222)
SWEP.CenteredAng = Angle(4.221, 2.813, -23.216)

SWEP.IronsightsFOV = 1
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.BlowbackPos         = Vector(00, -4, -0.025) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0.05, -0, 0)

SWEP.ReloadAttach = 2
SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.LowerPos = Vector(4.72, 0, 0.6)
SWEP.LowerAngles = Angle(16.801, -23.6, -16.2)

sound.Add({
	name = "Weapon_SMG2.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = "smg2/smg2_fire1.wav"
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
	
	self.DrawTime = CurTime() + 2
	self.BaseClass.Deploy(self)

	if !self.HasPlayedIntro then
		local vmodel = self.Owner:GetViewModel()
		vmodel:SetSequence( vmodel:LookupSequence("firstdraw") )
		self.HasPlayedIntro = true
	end
end


function SWEP:CustomThink()

	if self.Owner:Team() == TEAM_CP then
		if CLIENT and LocalPlayer() != self.Owner then return end 
		local myHands = self.Owner:GetHands()
		local b = myHands:LookupBone("ValveBiped.Bip01_Spine1")

		myHands:ManipulateBoneScale(b, Vector(0, 0, 0), SERVER or false)
		myHands:ManipulateBonePosition(b, Vector(0, 0, -19090), SERVER or false)
	end

	if self.DrawTime > CurTime() then
		
		return
	end
	if not self.Owner:IsWeaponRaised() then
		return 
	end
	local t = CurTime() - self.VTime
	--self:Isspr
	if self:IsSprinting() and not self:GetReloading() and t > 2 then
		if not self.VLowered then
			self.VLowered = true
			self:PlayAnim(ACT_VM_LOWERED_TO_IDLE)
		end
	end
	if not self:IsSprinting() and not self:GetReloading() and t > 2 then
		if self.VLowered then
			self.VLowered = false
			self:PlayAnim(ACT_VM_IDLE_TO_LOWERED)
		end
	end
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	-- Settings...
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		self:DrawModel()
	end
end

function SWEP:QueueIdle()
end

SWEP.ReloadProceduralCameraFrac = .2

function SWEP:GetReloadAnimation(pos, ang)
	local vm = self.Owner:GetViewModel()

	local bone = "Magazine"

	local tag_view = vm:GetBonePosition(vm:LookupBone(bone))

	local view = (tag_view-pos):GetNormalized():Angle() 

	return view
end

sound.Add({
	name = "Weapon_SMG2.Fire",
	channel = CHAN_STATIC,
	volume = 1,
	level = 60,
	pitch = {142, 148},
	sound = {
		"weapon/hmg/hmg_fire_player_01.wav",
		"weapon/hmg/hmg_fire_player_02.wav",
		"weapon/hmg/hmg_fire_player_03.wav",
		"weapon/hmg/hmg_fire_player_04.wav",
		"weapon/hmg/hmg_fire_player_05.wav",
		"weapon/hmg/hmg_fire_player_06.wav",
		"weapon/hmg/hmg_fire_player_07.wav",
		"weapon/hmg/hmg_fire_player_08.wav",
		"weapon/hmg/hmg_fire_player_09.wav",
		"weapon/hmg/hmg_fire_player_10.wav",
		"weapon/hmg/hmg_fire_player_11.wav",
		"weapon/hmg/hmg_fire_player_12.wav"
	}
})

sound.Add({
	name = "Weapon_SMG2.NPC_Fire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 140,
	pitch = {142, 148},
	sound = {
		")weapon/hmg/hmg_fire_player_01.wav",
		")weapon/hmg/hmg_fire_player_02.wav",
		")weapon/hmg/hmg_fire_player_03.wav",
		")weapon/hmg/hmg_fire_player_04.wav",
		")weapon/hmg/hmg_fire_player_05.wav",
		")weapon/hmg/hmg_fire_player_06.wav",
		")weapon/hmg/hmg_fire_player_07.wav",
		")weapon/hmg/hmg_fire_player_08.wav",
		")weapon/hmg/hmg_fire_player_09.wav",
		")weapon/hmg/hmg_fire_player_10.wav",
		")weapon/hmg/hmg_fire_player_11.wav",
		")weapon/hmg/hmg_fire_player_12.wav"
	}
})

sound.Add({
	name = "Weapon_SMG2.Bolt_Grab",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = 130,
	sound = "weapon/hmg/handling/hmg_bolt_grab_01.wav"
})
sound.Add({
	name = "Weapon_SMG2.",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = {97, 103},
	sound = "weapon//handling/.wav"
})
sound.Add({
	name = "Weapon_SMG2.Bolt_Pull",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = 130,
	sound = "weapon/akm/handling/akm_bolt_pull_01.wav"
})
sound.Add({
	name = "Weapon_SMG2.Bolt_Lock",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = 130,
	sound = "weapon/hmg/handling/hmg_bolt_lock_01.wav"
})
sound.Add({
	name = "Weapon_SMG2.Bolt_Release",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = 125,
	sound = "weapon/akm/handling/akm_bolt_release_01.wav"
})
sound.Add({
	name = "Weapon_SMG2.Mag_Release",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = 125,
	sound = "weapon/akm/handling/akm_mag_release_01.wav"
})
sound.Add({
	name = "Weapon_SMG2.Mag_Out",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = 125,
	sound = "weapon/akm/handling/akm_mag_out_01.wav"
})
sound.Add({
	name = "Weapon_SMG2.Mag_Futz",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = 125,
	sound = "weapon/akm/handling/akm_mag_futz_01.wav"
})
sound.Add({
	name = "Weapon_SMG2.Mag_In",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 60,
	pitch = 125,
	sound = "weapon/akm/handling/akm_mag_in_01.wav"
})

SWEP.LowerPos = Vector(2.72, 0, 0.6)
SWEP.LowerAngles = Angle(-9.801, 23.6, -6.2)