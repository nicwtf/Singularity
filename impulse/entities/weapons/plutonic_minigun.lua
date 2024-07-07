-- "addons\\plutonic\\lua\\weapons\\plutonic_minigun.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

-- FIXME: These sounds need better properties.

sound.Add({
	name="Minigun.Shots",
	sound={
		"^horizons_weapons/aer4/p_layer_01.wav",
		"^horizons_weapons/aer4/p_layer_02.wav",
		"^horizons_weapons/aer4/p_layer_03.wav",
		"^horizons_weapons/aer4/p_layer_04.wav",
		"^horizons_weapons/aer4/wpn_combine_mg_lfe_01.wav",
		"^horizons_weapons/aer4/wpn_combine_mg_lfe_02.wav",
		"^horizons_weapons/aer4/wpn_combine_mg_lfe_03.wav",
		"^horizons_weapons/aer4/wpn_combine_mg_lfe_04.wav"
	},
	channel=CHAN_STATIC,
	pitch = {95, 105},
	volume = {0.95, 1},
	level = 143
})

sound.Add({
	name = "Minigun.Layer",
	sound = {
		"^horizons_weapons/aer4/m_layer_01.wav",
		"^horizons_weapons/aer4/m_layer_02.wav",
		"^horizons_weapons/aer4/m_layer_03.wav",
		"^horizons_weapons/aer4/m_layer_04.wav"
	},
	channel = CHAN_WEAPON,
	pitch = {97, 101},
	volume = {.98, 1},
	level = 80
})

sound.Add({
	name = "Minigun.SecondLayer",
	sound = {
		")weapons/hlvr/minigun/wpn_combine_mg_mid_01.wav",
		")weapons/hlvr/minigun/wpn_combine_mg_mid_02.wav",
		")weapons/hlvr/minigun/wpn_combine_mg_mid_03.wav",
		")weapons/hlvr/minigun/wpn_combine_mg_mid_04.wav"
	},
	channel = CHAN_ITEM,
	pitch = {95, 105},
	volume = {0.95, 1},
	level = SNDLVL_GUNFIRE
})

sound.Add({
	name = "Minigun.WindDown",
	sound = ")horizons_weapons/aer4/wpn_combine_mg_wind_down_01.wav",
	channel = CHAN_AUTO,
	pitch = 100,
	volume = 1,
	level = 74
})

sound.Add({
	name = "Minigun.Windup",
	sound = ")weapons/hlvr/minigun/wpn_combine_mg_wind_up_01.wav",
	channel = CHAN_AUTO,
	pitch = 100,
	volume = 1,
	level = 74
})

SWEP.Base = "plutonic_base"

SWEP.PrintName = "Anti-Matter Enforcement Regulator MK-4"
SWEP.Category = "Plutonic: HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.WorldModel = Model("models/horizons_weapons/w_apf.mdl")
SWEP.ViewModel  = Model("models/horizons_weapons/c_apf_minigun.mdl")
SWEP.ViewModelFOV = 68
SWEP.BarrelLength = 12
SWEP.ViewModelOffset = Vector(-.4, 2, -1.43)
SWEP.CenteredPos = Vector(0,0,0)
SWEP.CenteredAng = Angle(0, 0, 0)

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false 

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Minigun.Shots")
SWEP.Primary.Recoil = 0.15-- bas recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 13
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.039
SWEP.Primary.Delay = Plutonic.FireRate.RPS(12)
SWEP.CannotChamber = true
SWEP.Primary.PenetrationScale = 0.89
SWEP.Attachments = {}

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 150
SWEP.Primary.DefaultClip = 150

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 2
SWEP.Spread.IronsightsMod = 0.4 -- multiply
SWEP.Spread.CrouchMod = 0.4 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.8 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 1.7 -- movement speed effect on spread (additonal)

SWEP.NoIronsights = true
SWEP.BlowbackPos         = Vector(00, -.1, -0.1) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle          = Angle(0.2, -0, 0)

SWEP.LoweredPos = Vector(1.406, -1.609, 1.809)
SWEP.LoweredAng = Angle(-9.849, 9.848, 0)
SWEP.IsAlwaysRaised = false

SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.MuzzleFlashAttachment = "muzzle"

sound.Add({
	name = "Weapon_Swing",
	sound = "weapons/universal/uni_weapon_draw.wav",
	channel = CHAN_AUTO,
	level = SNDLVL_GUNFIRE
})

sound.Add({
	name = "Magazine.Out",
	sound = "weapons/ar2/ar2_magout.wav"
})

-- weapons/700n-close.wav

sound.Add({
	name = "Magazine.In",
	sound = "weapons/ar2/ar2_magin.wav"
})

--weapons/700n-eject.wav

sound.Add({
	name = "Weapon_Swing2",
	sound = "weapons/tfa_hl2r/uni/uni_weapon_draw_01.wav"
})

SWEP.SpinSpart = 0
SWEP.SpinTransitionDelay = 0
SWEP.IronsightsSpeed = 1

function SWEP:ExtraDataTables()
	self:NetworkVar("Bool", 5, "BarrelSpin")
	self:NetworkVar("Bool", 6, "FullSpin")
end

function SWEP:IsFullySpun()
	return self:GetFullSpin()
end

function SWEP:CanShoot()
	if not self:IsFullySpun() then return false end

	-- Inherit
	return self:CanPrimaryAttack() and not self:GetBursting() and not (self.LoweredPos and self:IsSprinting()) and self:GetReloadTime() < CurTime()
end



--[[function SWEP:ShootEffects()
	if not self:GetIronsights() or not self.UseIronsightsRecoil then
		if self.PrimaryFireSequence then
			local vm = self.Owner:GetViewModel()
			vm.ResetSequenceInfo( vm )
			vm.SetSequence( vm, self.PrimaryFireSequence )
			vm:SendViewModelMatchingSequence(vm:LookupSequence(self.PrimaryFireSequence))
		else
			self:PlayAnim(ACT_VM_PRIMARYATTACK)
			self:QueueIdle()
		end
		
	else
		self.ViewModelPos = self.IronsightsPos + self.BlowbackPos + (self.ViewModelOffset or Vector())
		self.ViewModelAng = self.IronsightsAng + self.BlowbackAngle + (self.ViewModelOFfsetAng or Angle())
		self:SetIronsightsRecoil( 2 )
		self.CanDecreaseBlowback = CurTime() + 0.1
	end

	if CLIENT then
		if not (impulse.IronsightsMuzzleFlashFix and not self:GetIronsights()) then
			local vm = self.Owner:GetViewModel()
			--PrintTable(vm:GetAttachments())
			local attachment = vm:LookupAttachment( self.IronsightsMuzzleFlashAttachment or "muzzle")
			local posang = vm:GetAttachment(attachment)

			if posang then
				

				if (self.IronsightsMuzzleParticle) then
					--posang.Ang:RotateAroundAxis(Vector(0,1,0),-90)
					--posang.Ang:RotateAroundAxis(vm:GetAngles():Up(),180)
					ParticleEffect(self.IronsightsMuzzleFlash, posang.Pos, posang.Ang, self)
				else
				end
			end
		end
	end

	
	-- self.Owner:MuzzleFlash()
	self:PlayAnimWorld(ACT_VM_PRIMARYATTACK)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if self.IronsightsMuzzleFlash and CLIENT then
		local attachment = self:LookupAttachment( self.IronsightsMuzzleFlashAttachment or "muzzle")
		local ef = EffectData()
					ef:SetOrigin(self.Owner:GetShootPos())
					ef:SetStart(self.Owner:GetShootPos())
					ef:SetNormal(self.Owner:EyeAngles():Forward())
					ef:SetEntity(self)
					ef:SetAttachment(1)
					ef:SetScale(self.IronsightsMuzzleFlashScale or 1)
		self:CreateParticleEffect("hl2mmod_muzzleflash_smg1", 2, {attachtype=PATTACH_POINT_FOLLOW,entity=self,position=self.Owner:GetShootPos()})
	end

	if self.CustomShootEffects then
		self.CustomShootEffects(self)
	end
end]]--
--SWEP.IronSightsPos = Vector(-1.28, -9.36, -13.12)
--SWEP.IronSightsAng = Vector(46.799, -6.801, 0)
function SWEP:GetOffset()
	if self:GetReloading() then return end

	if self.LoweredPos and self:IsSprinting() then
		return self.LoweredPos, self.LoweredAng
	end

	if not self:GetBarrelSpin() then
		-- This will definitely need to be adjusted
		return Vector(-1.28, -9.36, -13.12), Angle(46.799, -6.801, 0)
	end
end

function SWEP:PrimaryAttack()
	if not self:GetBarrelSpin() then return end
	if not self:CanShoot() then return end

	local clip = self:Clip1()

	if self.Primary.Burst and clip >= 3 then
		self:SetBursting(true)
		self.Burst = 3

		local delay = CurTime() + ((self.Primary.Delay * 3) + (self.Primary.BurstEndDelay or 0.3))
		self:SetNextPrimaryFire(delay)
		self:SetReloadTime(delay)
	elseif clip >= 1 then
		-- FIXME: Doesn't have flags to allow multiple sounds on the same channel, this will only play a single sound! <FIXED, TEST>
		
		self:TakePrimaryAmmo(1)

		self:ShootBullet(self.Primary.Damage, self.Primary.NumShots, self:CalculateSpread())

		self:AddRecoil()
		self:ViewPunch()

		self:EmitSound(
			"Minigun.Layer"
		)
		self:EmitSound(
			self.Primary.Sound
		)

		


		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetReloadTime(CurTime() + self.Primary.Delay)
	else
		self:EmitSound(self.EmptySound)
		self:Reload()
		self:SetNextPrimaryFire(CurTime() + 1)
	end
end

-- We can layer things on this
function SWEP:CustomThink()
	if not self.Owner:IsWeaponRaised() then return end
	if self:GetReloading() then return end

	if self.Owner:KeyDown( IN_ATTACK ) and not self:IsSprinting() then
		if self.SpinTransitionDelay > CurTime() then return end
		if not (self:GetBarrelSpin() or false) then
			self:EmitSound(
					"Minigun.Windup",
					nil,
					nil,
					nil,
					CHAN_BODY,
					SND_NOFLAGS,
					0
				)
			self:SetBarrelSpin(true)
			self.SpinStart = CurTime() + 1.2
			self.SpinTransitionDelay = CurTime() + 1.1
		end

		if SERVER then
			--self.Owner:Notify(CurTime() > (self.SpinStart or 0))
			self:SetFullSpin(CurTime() > (self.SpinStart or 0))
		end
	else
		if self.SpinTransitionDelay > CurTime() then return end
		if self:GetBarrelSpin() then
			self:EmitSound(
					"Minigun.Winddown",
					nil,
					nil,
					nil,
					CHAN_BODY,
					SND_NOFLAGS,
					0
				)
			self:SetFullSpin(false)
			self:SetBarrelSpin(false)
			self.SpinStart = CurTime() + 1.2
			self.SpinTransitionDelay = CurTime() + 1.1
		end
	end
end

--hook.Add(eventName, identifier, func)

function SWEP:ChangeBarrelSpin(amt)
	self:SetBarrelSpin( math.Clamp(self:GetBarrelSpin() + amt, 0, 1) )
end

function SWEP:SecondaryAttack()
	-- Predicted value, server authority over it tho
	
end