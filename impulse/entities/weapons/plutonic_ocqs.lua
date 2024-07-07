-- "addons\\plutonic\\lua\\weapons\\plutonic_ocqs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base_chargeup"

SWEP.PrintName = "OCQS"
SWEP.Category = "Plutonic: HL2RP Weapons"
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.WorldModel = Model("models/weapons/heavyshotgun/w_shotgun_heavy.mdl")
SWEP.ViewModel = Model("models/weapons/c_landis_ocqs.mdl")
SWEP.Attachments = {}
SWEP.ViewModelFOV = 64
SWEP.ViewModelOffset = Vector(-1.4, -4, .4)

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CanBreachDoors = true

SWEP.Enum = {}
SWEP.Enum.WeaponType = Plutonic.Enum.WeaponType.SubmachineGun

SWEP.BarrelLength = 14

SWEP.CSMuzzleFlashes = false


sound.Add({
	name = "Weapon_OCQS.Chargeup",
	sound = "charger/shield/wpn_charger_flashbang_windup_01.wav",
	channel = CHAN_WEAPON,
	level = 46,
	volume = .7
})

sound.Add({
	name = "Weapon_OCQS.Fail",
	sound = "horizons_weapons/ocqs/combine_button_fail.wav",
	channel = CHAN_WEAPON,
	level = 46,
	volume = .7
})

sound.Add({
	name = "Weapon_OCQS.Fire",
	sound = {
		"pshotgun/shotgun_fire1.wav",
		"pshotgun/shotgun_fire2.wav",
		"pshotgun/shotgun_fire3.wav",
		"pshotgun/shotgun_fire4.wav",
		"pshotgun/wpn_combine_shotgun_fire_body_01.wav",
		"pshotgun/wpn_combine_shotgun_fire_body_02.wav"
		},
	channel = CHAN_WEAPON,
	level = 80,
	volume = 1.0
})

game.AddAmmoType({
	name = "WHSpikes",
	dmgtype = DMG_BULLET,
	tracer = TRACER_LINE,
	force = 5000,
	minsplash = 10,
	maxsplash = 5
})

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_OCQS.Fail")
SWEP.CannotChamber = true
SWEP.Primary.Sound = Sound("Weapon_OCQS.Fire")
SWEP.Primary.Recoil = 4.24 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.RecoilRecoveryRate = 2.5
SWEP.Primary.Damage = 25
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.012
SWEP.Primary.Delay = Plutonic.FireRate.RPM(187)

SWEP.Primary.PenetrationScale = 3

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 24
SWEP.Primary.DefaultClip = 24

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Primary.StartFalloff = 1200
SWEP.Primary.EndFalloff = 1800
SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.5 -- multiply
SWEP.Spread.CrouchMod = 0.8 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.09 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 04.42 -- movement speed effect on spread (additonal)


SWEP.IronsightsPos = Vector(-1.78, -3.5, .4)
SWEP.IronsightsAng = Angle(0, -0, -6)
SWEP.IronsightsFOV = 0.85
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = true
SWEP.IronsightsRecoilVisualMultiplier = 1
SWEP.BlowbackPos         = Vector(0, -5.08, 1.1) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0, 0, 0)

SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.MuzzleFlashSize = 1024
SWEP.MuzzleFlashColor = Color(10, 140, 255)
SWEP.MuzzleFlashShadow = true
SWEP.LoweredPos = Vector(1, -4, -4)
SWEP.LoweredAng = Angle(2, 30, -10)
SWEP.lastplayed = 0
SWEP.CenteredPos = Vector(-2.631,1.22,  -6.58)
SWEP.CenteredAng = Angle(2.92, 2.509, -17.216)
function SWEP:OnChargeStateChanged(state)
	if state and self.Owner:IsWeaponRaised() then
		if CurTime() < self.lastplayed then return end
		self.lastplayed = CurTime() + 1
		self:EmitSound("horizons_weapons/ocqs/eblaster_charge_leds_01.wav")
	end
end

function SWEP:ToggleShotgunMode()
end

function SWEP:Reload()
	if not self:CanReload() then return end

	self.Owner:DoReloadEvent()

	if not self.DoEmptyReloadAnim or self:Clip1() != 0 then
		self:PlayAnim(ACT_VM_RELOAD)
	else
		self:PlayAnim(ACT_VM_RELOAD_EMPTY)
	end
	self:QueueIdle()

	if self.ReloadSound then 
		self:EmitSound(Sound(self.ReloadSound))
	elseif self.OnReload then
		self.OnReload(self)
	end

	if self.ReloadWorldSound then
		if SERVER then self:EmitWorldSound(self.ReloadWorldSound) end 
	end

	self:SetReloading( true )
	self:SetReloadTime( CurTime() + self.Owner:GetViewModel():SequenceDuration() )

	hook.Run("LongswordWeaponReload", self.Owner, self)
end

hook.Remove("StartCommand", "OCQS", function(ply, cmd)
end)

SWEP.Secondary.Automatic = true

sound.Add({
	name = "Weapon_OCQS.SwitchMode",
	sound = "horizons_weapons/ocqs/combine_button_fail.wav",
	channel = CHAN_WEAPON,
	level = 46,
	volume = .7
})

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_WALK) then
		if self:GetShotgunMode() == 1 then -- Rifle Mode
			-- Set mode
			self:SetShotgunMode(2)
			self:SetNextSecondaryFire(CurTime() + 2)

			-- Update values
			self.Primary.Damage = 15
			self.Primary.NumShots = 10
			self.Primary.Cone = 0.1
			self.Primary.Delay = Plutonic.FireRate.RPM(60)
			self.Primary.PenetrationScale = 1.3
			self.Primary.StartFalloff = 0
			self.Primary.EndFalloff = 700
			self.Primary.Recoil = 10.5
			self.Primary.RecoilRecoveryRate = 1.5
			self.Spread.Min = 0.1
			self.Spread.Max = 0.2
			self.Spread.IronsightsMod = 0.5
			self.Spread.CrouchMod = 0.8
			self.Spread.AirMod = 1.2
			self.Spread.RecoilMod = 0.09
			self.Spread.VelocityMod = 2

			-- Play sound
			self:EmitSound("Weapon_OCQS.SwitchMode")
		else
			self:SetShotgunMode(1)
			self:SetNextSecondaryFire(CurTime() + 2)

			-- REVERT
			self.Primary.Damage = 25
			self.Primary.NumShots = 1
			self.Primary.Cone = 0.022
			self.Primary.Delay = Plutonic.FireRate.RPM(130)
			self.Primary.PenetrationScale = 0.8
			self.Primary.StartFalloff = 1200
			self.Primary.EndFalloff = 1800
			self.Primary.Recoil = 2.24
			self.Primary.RecoilRecoveryRate = 2.5
			self.Spread.Min = 0
			self.Spread.Max = 0.1
			self.Spread.IronsightsMod = 0.5
			self.Spread.CrouchMod = 0.8
			self.Spread.AirMod = 1.2
			self.Spread.RecoilMod = 0.09
			self.Spread.VelocityMod = 0.42
			
			-- Play sound
			self:EmitSound("Weapon_OCQS.SwitchMode")
		end
	end
end

function SWEP:ExtraDataTables()
	self:NetworkVar("Int", 0, "ShotgunMode")

	if SERVER then
		self:SetShotgunMode(1)
	end
end

function SWEP:CustomShootEffects()
	if SERVER then return end
end

function SWEP:DrawHUD()
	if self:GetShotgunMode() == 2 then
		draw.DrawText("FIRE MODE: SHOTGUN", "Impulse-Elements18", ScrW() / 2, ScrH() - 100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
	else
		draw.DrawText("FIRE MODE: RIFLE", "Impulse-Elements18", ScrW() / 2, ScrH() - 100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
	end
end

function SWEP:CanShoot()
    return self:CanPrimaryAttack() and 
    not self:GetBursting() and 
    not (self.LoweredPos and self:IsSprinting() and not self.Charged) and 
    self:GetReloadTime() < CurTime() and 
    self.Charged
end

sound.Add({
    name                = "Magazine.ShOut" ,
    channel     = CHAN_WEAPON,
    volume              = 1,
    soundlevel  = 100,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "pshotgun/wpn_shotgun_foley_open_chamber_01.wav"
})

sound.Add({
    name                = "Magazine.ShIn" ,
    channel     = CHAN_WEAPON,
    volume              = 1,
    soundlevel  = 100,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "pshotgun/wpn_shotgun_foley_rack_forward_01.wav"
})

sound.Add({
    name                = "Cock" ,
    channel     = CHAN_WEAPON,
    volume              = 1,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "pshotgun/wpn_shotgun_foley_close_chamber_01.wav"
})