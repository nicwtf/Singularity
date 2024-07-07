-- "addons\\plutonic\\lua\\weapons\\plutonic_stunstick.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "plutonic_base_melee"

SWEP.PrintName = "Stun Baton"
SWEP.Category = "Plutonic: HL2RP Weapons"



SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee"

SWEP.WorldModel = Model("models/weapons/w_stunbaton.mdl")
SWEP.ViewModel = Model("models/weapons/c_stunstick.mdl")
SWEP.ViewModelFOV = 70

SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.SwayLevel = 1
SWEP.SwayIdle = 1
SWEP.SwayBob = 3.3

SWEP.SwayRightMultiplier = 2
SWEP.SwayUpMultiplier = 2
SWEP.LowerAngles = Angle(-10, 2, -15)

SWEP.CSMuzzleFlashes = false
SWEP.HitAnim = ACT_VM_HITCENTER
SWEP.Primary.Sound = Sound("weapons/stunstick/stunstick_swing1.wav")
SWEP.Primary.ImpactSound = Sound("weapons/stunstick/stunstick_impact2.wav")
SWEP.Primary.ImpactEffect = "StunstickImpact"
SWEP.Primary.FlashTime = 0.6
SWEP.Primary.Recoil = 1.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 12 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.7
SWEP.Primary.Range = 75
SWEP.Primary.Cone = 0.002
SWEP.Spread = {}
SWEP.Spread.Min = 0.00
SWEP.Spread.Max = 4
SWEP.Spread.IronsightsMod = 0.5 -- multiply
SWEP.Spread.CrouchMod = 0.5 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 1.2 -- movement speed effect on spread (additonal)
SWEP.Attachments = {
	riot_shield = {
		Cosmetic = {
			Model = "models/bshields/rshield.mdl",
			PlayerParent = true,
			Bone = "ValveBiped.Bip01_L_Hand",
			Pos = Vector(-14.3, -2, 20),
			Ang = Angle(80, 0, 0),
			Scale = 0.85,
			Skin = 0,
			World = {
				Bone = "ValveBiped.Bip01_L_Hand",
				Pos = Vector(-3, 2, 0),
				Ang = Angle(-25, 90, 0),
				Scale = 0.85
			}
		},
		ModSetup = function(e)
		end,
		ModCleanup = function(e)
		end
	}
}

SWEP.CenteredPos = Vector(-19.031,1.22,  -7.58)
SWEP.CenteredAng = Angle(2.92, -12.509,-21.216)

sound.Add({
	name = "lsStunstickBuzz",
	channel = CHAN_AUTO,
	volume = 0.34,
	level = 45,
	sound = ")ambient/machines/combine_shield_touch_loop1.wav"
})

function SWEP:ExtraDataTables()
	self:NetworkVar("Int", 5, "Mode")
end

function SWEP:ExtraHolster()
	self.Owner:StopSound("lsStunstickBuzz")

	self:SetMode(1)
end

function SWEP:OnRemove()
	if IsValid(self.Owner) then
		self.Owner:StopSound("lsStunstickBuzz")
	end
end

function SWEP:OnLowered()
	self:SetMode(1)


	self.Owner:StopSound("lsStunstickBuzz")
end

function SWEP:PrePrimaryAttack()
	local mode = self:GetMode()

	if mode == 1 then
		self.Primary.Damage = 3
		self.Primary.ImpactEffect = nil
		self.Primary.FlashTime = 0.2
		self.Primary.Sound = Sound("WeaponFrag.Roll")
		self.Primary.ImpactSound = Sound("physics/plastic/plastic_barrel_impact_bullet1.wav")
	else
		if mode == 2 then

			local trace = {}
			trace.start = self.Owner:GetShootPos()
			trace.endpos = trace.start + self.Owner:GetAimVector() * 72
			trace.filter = self.Owner
			trace.mins = Vector(-7, -7, -30)
			trace.maxs = Vector(8, 8, 10)

			local tr = util.TraceHull(trace)
			local ent = tr.Entity

			self.Primary.Damage = 6

			if ent and IsValid(ent) then
				if ent:IsPlayer() or ent:IsNPC() then
					if ent:IsRebel() then
						self.Primary.FlashTime = 8
					else
						self.Primary.FlashTime = 0.6
					end
				else
					self.Primary.FlashTime = 0.6
				end
			else
				self.Primary.FlashTime = 0.6
			end
		else
			self.Primary.Damage = 10
			self.Primary.FlashTime = 0.65
		end

		if CLIENT then
			if impulse.GetSetting("perf_dynlight") then
				local dlight = DynamicLight(self:EntIndex())

				if dlight then
					dlight.pos = self.Owner:GetShootPos()
					dlight.r = 60
					dlight.g = 60
					dlight.b = 255
					dlight.brightness = 6
					dlight.Decay = 312
					dlight.Size = 256
					dlight.DieTime = CurTime() + 1.65
				end
			end
		end

		self.Primary.ImpactEffect = "StunstickImpact"
		self.Primary.Sound = Sound("weapons/stunstick/stunstick_swing1.wav")
		self.Primary.ImpactSound = Sound("weapons/stunstick/stunstick_impact2.wav")
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_WALK) then
		local oldMode = self:GetMode()
		local newMode = oldMode + 1

		if newMode > 3 then
			newMode = 1
			self.Owner:StopSound("lsStunstickBuzz")
		end

		if SERVER then
			self:SetMode(newMode)

			local seq = "deactivatebaton"

			if newMode > 1 then
				self.Owner:EmitSound("weapons/stunstick/spark3.wav", 100, math.random(90, 110))
				seq = "activatebaton"
			else
				self.Owner:EmitSound("weapons/stunstick/spark"..math.random(1, 2)..".wav", 100, math.random(90, 110))
			end

			if newMode == 3 then
				self.Owner:EmitSound("lsStunstickBuzz")
			end

			if self.Owner:Team() == TEAM_CP then
				self.Owner:ForceSequence(seq, nil, nil, true)
			end
		end

		return self:SetNextSecondaryFire(CurTime() + 1)
	end

	self.Owner:LagCompensation(true)

	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = trace.start + self.Owner:GetAimVector() * 72
	trace.filter = self.Owner
	trace.mins = Vector(-7, -7, -30)
	trace.maxs = Vector(8, 8, 10)

	local tr = util.TraceHull(trace)
	local ent = tr.Entity
	self.Owner:LagCompensation(false)

	if SERVER and ent and IsValid(ent) then
		if ent:IsPlayer() then
			self.Owner:EmitSound("weapons/crossbow/hitbod"..math.random(1, 2)..".wav")
			local direction = self.Owner:GetAimVector() * 330
			direction.z = 0

			ent:SetVelocity(direction)

			if self.Owner:Team() == TEAM_CP then
				self.Owner:ForceSequence("pushplayer")
			end

			self:SetNextSecondaryFire(CurTime() + 2)
		end
	end
end

-- based on NS sunstick effects:

local STUNSTICK_GLOW_MATERIAL = Material("effects/stunstick")
local STUNSTICK_GLOW_MATERIAL2 = Material("effects/blueflare1")
local STUNSTICK_GLOW_MATERIAL_NOZ = Material("sprites/light_glow02_add_noz")

local color_glow = Color(128, 128, 128)

function SWEP:ExtraDrawWorldModel()
	self:DrawModel()
	local mode = self:GetMode()

	if not mode or mode < 2 then
		return
	end

	local size

	if mode == 2 then
		size = math.Rand(4.0, 6.0)
	else
		size = math.Rand(6.5, 7.5)
	end

	local glow = math.Rand(0.6, 0.8) * 255
	local color = Color(glow, glow, glow)
	local attachment = self:GetAttachment(1)

	if (attachment) then
		local position = attachment.Pos

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL2)
		render.DrawSprite(position, size * 2, size * 2, color)

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL)
		render.DrawSprite(position, size, size + 3, color_glow)
	end
end

local NUM_BEAM_ATTACHEMENTS = 18
local BEAM_ATTACH_CORE_NAME	= "sparkrear"

SWEP.MuzzleFlashAttachment = "sparkrear"

function SWEP:PostDrawViewModel()
	local mode = self:GetMode()

	if not mode or mode < 2 then
		return
	end

	local vm = LocalPlayer():GetViewModel()

	if not IsValid(vm) then
		return
	end

	if impulse.GetSetting("perf_dynlight") then
		if not self.VMDynLight then
			self.VMDynLight = DynamicLight(self:EntIndex())
		end

		local light = self.VMDynLight

		local attachment = vm:GetAttachment(vm:LookupAttachment(BEAM_ATTACH_CORE_NAME))

		if light then
			light.Pos = attachment.Pos
			light.r = 60
			light.g = 60
			light.b = 255
			light.brightness = mode == 3 and 10 or 6
			light.Decay = 312
			light.Size = 64
			light.DieTime = CurTime() + 1.65
		end
	end

	cam.Start3D(EyePos(), EyeAngles())
		local size

		if mode == 2 then
			size = math.Rand(3.0, 4.0)
		else
			size = math.Rand(5.5, 6.5)
		end

		local color = Color(60, 210, 255, 50 + math.sin(RealTime() * 2)*20)

		STUNSTICK_GLOW_MATERIAL_NOZ:SetFloat("$alpha", color.a / 255)

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL_NOZ)

		local attachment = vm:GetAttachment(vm:LookupAttachment(BEAM_ATTACH_CORE_NAME))

		if (attachment) then
			render.DrawSprite(attachment.Pos, size * 10, size * 15, color)
		end

		for i = 1, NUM_BEAM_ATTACHEMENTS do
			local attachment = vm:GetAttachment(vm:LookupAttachment("spark"..i.."a"))

			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end

			local attachment = vm:GetAttachment(vm:LookupAttachment("spark"..i.."b"))

			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end
		end
	cam.End3D()
end
