-- "addons\\plutonic\\lua\\weapons\\plutonic_portable_ied.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.PrintName = "Portable IED"
SWEP.Category = "Plutonic: HL2RP Weapons"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.HoldType = "melee1"

SWEP.ViewModel = Model("models/weapons/v_hands.mdl")
SWEP.WorldModel	= "models/props_c17/SuitCase_Passenger_Physics.mdl"

SWEP.ViewModelFOV = 0
SWEP.Attachments = {}
SWEP.ViewModelFlip = false
SWEP.HoldType = "normal"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""
SWEP.IsAlwaysRaised = true

SWEP.UseHands = false

SWEP.HoldingEntity = nil
SWEP.CarryHack = nil
SWEP.Constr = nil
SWEP.PreviousOwner = nil

local THROW_VELOCITY_CAP = 150
local CARRY_FORCE_LIMIT = 40000
local CARRY_WEIGHT_LIMIT = 100
local PLAYER_PICKUP_RANGE = 200

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

local player = player
local IsValid = IsValid
local CurTime = CurTime

if SERVER then
	function SWEP:Deploy()
		if not self.Owner:IsSuperAdmin() then
			self.Owner:StripWeapon("plutonic_portable_ied")
		end
	end
end

function SWEP:PrimaryAttack()
	self:EmitSound("weapons/c4/c4_beep1.wav", 90)

	timer.Simple(1.5, function()
		if not IsValid(self) then
			return
		end

		local debris = {}

		for i=1,9 do
			local flyer = ents.Create("prop_physics")
			flyer:SetPos(self:GetPos())

			flyer:SetCollisionGroup(1)
					
			if i > 4 then
				flyer:SetModel("models/props_debris/wood_chunk08b.mdl")
			else
				flyer:SetModel("models/combine_helicopter/bomb_debris_"..math.random(2, 3)..".mdl")
			end

			flyer:Spawn()
			flyer:Ignite(30)

			local phys = flyer:GetPhysicsObject()

			if phys and IsValid(phys) then
				phys:SetVelocity(Vector(math.random(-150, 150), math.random(-150, 150), math.random(-150, 150)))
			end

			table.insert(debris, flyer)
		end

		timer.Simple(40, function()
			for v,k in pairs(debris) do
				if IsValid(k) then
					k:Remove()
				end
			end
		end)

		local explodeEnt = ents.Create("env_explosion")
		explodeEnt:SetPos(self:GetPos())

		if IsValid(self.Placer) then
			explodeEnt:SetOwner(self.Placer)
		end 

		explodeEnt:Spawn()
		explodeEnt:SetKeyValue("iMagnitude", "355")
		explodeEnt:Fire("explode", "", 0)

		local fire = ents.Create("env_fire")
		fire:SetPos(self:GetPos())
		fire:Spawn()
		fire:Fire("StartFire")

		timer.Simple(60, function()
			if IsValid(fire) then
				fire:Remove()
			end
		end)

		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos())
		util.Effect("Explosion", effectData)

		self:EmitSound("weapons/c4/c4_explode1.wav", 700)
		self:EmitSound("weapons/c4/c4_exp_deb1.wav", 135)
		self:EmitSound("weapons/c4/c4_exp_deb2.wav", 135)
		self:EmitSound("ambient/atmosphere/terrain_rumble1.wav", 128)

		for v,k in pairs(player.GetAll()) do
			k:SurfacePlaySound("ambient/levels/streetwar/city_battle7.wav")
		end

		util.ScreenShake(self:GetPos(), 4, 2, 2.5, 100000)

		self:Remove()

		local pos = self:GetPos()

		timer.Simple(1, function()
			for v,k in pairs(ents.FindByClass("prop_ragdoll")) do
				if k:GetPos():DistToSqr(pos) < (1200 ^ 2) then
					k:Ignite(40)
				end
			end
		end)
	end)
end